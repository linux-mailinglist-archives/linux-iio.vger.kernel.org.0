Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001732A760B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 04:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgKEDY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Nov 2020 22:24:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:4579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKEDY5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Nov 2020 22:24:57 -0500
IronPort-SDR: XMBilGXkcShznfiiRD4C6Zvx/Ho6rnEUtO49vp7kZ0Hx6/uFsrUdIFNSzN6E+PXt5DlWim5jQR
 iC8OxEcPfF8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169465847"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="169465847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:24:57 -0800
IronPort-SDR: sqEucWHkkre8wyC7DUAUyJx211JrAsIp+rLSxWZyd7BQC0HEviTiKpgpEdSDJme6VQ7WtH7ThW
 ROcC5zOvabGQ==
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="539194120"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.229.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:24:56 -0800
Message-ID: <772df8bf24315fb46c35dad3ede32f779fd6fb47.camel@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-hub: Fix issue with devices with no
 report ID
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Pablo Ceballos <pceballos@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Nov 2020 19:24:56 -0800
In-Reply-To: <20201103002939.688690-1-pceballos@google.com>
References: <20201103002939.688690-1-pceballos@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-11-02 at 19:29 -0500, Pablo Ceballos wrote:
> Some HID devices don't use a report ID because they only have a
> single
> report. In those cases, the report ID in struct hid_report will be
> zero
> and the data for the report will start at the first byte, so don't
> skip
> over the first byte.
> 
> Signed-off-by: Pablo Ceballos <pceballos@google.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/hid-sensor-hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 94c7398b5c27..3dd7d3246737 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -483,7 +483,8 @@ static int sensor_hub_raw_event(struct hid_device
> *hdev,
>  		return 1;
>  
>  	ptr = raw_data;
> -	ptr++; /* Skip report id */
> +	if (report->id)
> +		ptr++; /* Skip report id */
>  
>  	spin_lock_irqsave(&pdata->lock, flags);
>  

