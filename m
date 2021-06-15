Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E933A8905
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFOTBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 15:01:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:32983 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhFOTBw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Jun 2021 15:01:52 -0400
IronPort-SDR: A6enz0nQc4g0orvMdNDSglvufpLXP9rxiGRC3Uz1lVGSj3GE84vDSPv4kS5xTw/4Z5lltrEck4
 6XNnWSCuqFaA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267200862"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="267200862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:59:45 -0700
IronPort-SDR: DLY6cTYLm/d5JLdoxy8HwHrte1hh6kMSVLkk6w9YxDTEjqKLxnFW7pPqMQZgmqrOUO1apOKTdN
 KFx6TSbffbqg==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="471738694"
Received: from scha1-mobl1.amr.corp.intel.com ([10.209.8.199])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:59:45 -0700
Message-ID: <513b9a637987c0c4152a47cd3190a27c34fc8ef2.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: use async resume function
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Jun 2021 11:59:44 -0700
In-Reply-To: <20210613032507.7474-1-xiang.ye@intel.com>
References: <20210613032507.7474-1-xiang.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-06-13 at 11:25 +0800, Ye Xiang wrote:
> ISH IPC driver uses asynchronous workqueue to do resume now, but
> there is
> a potential timing issue: when child devices resume before bus
> driver, it
> will cause child devices resume failed and cannot be recovered until
> reboot. The current implementation in this case do wait for IPC to
> resume
> but fail to accommodate for a case when there is no ISH reboot and
> soft
> resume is taking time. This issue is apparent on Tiger Lake platform
> with
> 5.11.13 kernel when doing suspend to idle then resume(s0ix) test. To
> resolve this issue, we change ISHTP HID client to use asynchronous
> resume
> callback too. In the asynchronous resume callback, it waits for the
> ISHTP
> resume done event, and then notify ISHTP HID client link ready.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c | 15 +++++++++-
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  1 +
>  drivers/hid/intel-ish-hid/ishtp/bus.c        | 29 +++++++++++++++---
> --
>  include/linux/intel-ish-client-if.h          |  2 ++
>  4 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 7167412d89d9..9d53e85fdef3 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -779,6 +779,17 @@ static void hid_ishtp_cl_reset_handler(struct
> work_struct *work)
>  	}
>  }
>  
> +static void hid_ishtp_cl_resume_handler(struct work_struct *work)
> +{
> +	struct ishtp_cl_data *client_data = container_of(work, struct
> ishtp_cl_data, resume_work);
> +	struct ishtp_cl *hid_ishtp_cl = client_data->hid_ishtp_cl;
> +
> +	if (ishtp_wait_resume(ishtp_get_ishtp_device(hid_ishtp_cl))) {
> +		client_data->suspended = false;
> +		wake_up_interruptible(&client_data->ishtp_resume_wait);
> +	}
> +}
> +
>  void (*hid_print_trace)(void *unused, const char *format, ...);
>  
>  /**
> @@ -817,6 +828,8 @@ static int hid_ishtp_cl_probe(struct
> ishtp_cl_device *cl_device)
>  	init_waitqueue_head(&client_data->ishtp_resume_wait);
>  
>  	INIT_WORK(&client_data->work, hid_ishtp_cl_reset_handler);
> +	INIT_WORK(&client_data->resume_work,
> hid_ishtp_cl_resume_handler);
> +
>  
>  	hid_print_trace = ishtp_trace_callback(cl_device);
>  
> @@ -918,7 +931,7 @@ static int hid_ishtp_cl_resume(struct device
> *device)
>  
>  	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
>  			hid_ishtp_cl);
> -	client_data->suspended = false;
> +	schedule_work(&client_data->resume_work);
>  	return 0;
>  }
>  
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h
> b/drivers/hid/intel-ish-hid/ishtp-hid.h
> index 5ffd0da3cf1f..e5fa753fe92f 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.h
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
> @@ -140,6 +140,7 @@ struct ishtp_cl_data {
>  	int multi_packet_cnt;
>  
>  	struct work_struct work;
> +	struct work_struct resume_work;
>  	struct ishtp_cl_device *cl_device;
>  };
>  
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 0d6465f0eaa8..ead6c8f32759 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -329,13 +329,6 @@ static int ishtp_cl_device_resume(struct device
> *dev)
>  	if (!device)
>  		return 0;
>  
> -	/*
> -	 * When ISH needs hard reset, it is done asynchrnously, hence
> bus
> -	 * resume will  be called before full ISH resume
> -	 */
> -	if (device->ishtp_dev->resume_flag)
> -		return 0;
> -
>  	driver = to_ishtp_cl_driver(dev->driver);
>  	if (driver && driver->driver.pm) {
>  		if (driver->driver.pm->resume)
> @@ -863,6 +856,28 @@ struct device *ishtp_device(struct
> ishtp_cl_device *device)
>  }
>  EXPORT_SYMBOL(ishtp_device);
>  
> +/**
> + * ishtp_wait_resume() - Wait for IPC resume
> + *
> + * Wait for IPC resume
> + *
> + * Return: resume complete or not
> + */
> +bool ishtp_wait_resume(struct ishtp_device *dev)
> +{
> +	/* 50ms to get resume response */
> +	#define WAIT_FOR_RESUME_ACK_MS		50
> +
> +	/* Waiting to get resume response */
> +	if (dev->resume_flag)
> +		wait_event_interruptible_timeout(dev->resume_wait,
> +						 !dev->resume_flag,
> +						 msecs_to_jiffies(WAIT_
> FOR_RESUME_ACK_MS));
> +
> +	return (!dev->resume_flag);
> +}
> +EXPORT_SYMBOL_GPL(ishtp_wait_resume);
> +
>  /**
>   * ishtp_get_pci_device() - Return PCI device dev pointer
>   * This interface is used to return PCI device pointer
> diff --git a/include/linux/intel-ish-client-if.h
> b/include/linux/intel-ish-client-if.h
> index 1153e0030133..ec3a6ccbece4 100644
> --- a/include/linux/intel-ish-client-if.h
> +++ b/include/linux/intel-ish-client-if.h
> @@ -76,6 +76,8 @@ int ishtp_register_event_cb(struct ishtp_cl_device
> *device,
>  
>  /* Get the device * from ishtp device instance */
>  struct device *ishtp_device(struct ishtp_cl_device *cl_device);
> +/* wait for IPC resume */
> +bool ishtp_wait_resume(struct ishtp_device *dev);
>  /* Trace interface for clients */
>  void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
>  /* Get device pointer of PCI device for DMA acces */
> 
> base-commit: f5711311bfa1abcc64c6dd1e912666a8c0b29a1a

