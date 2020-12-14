Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B72D9994
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 15:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439164AbgLNOP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 09:15:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:30482 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439175AbgLNOPw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Dec 2020 09:15:52 -0500
IronPort-SDR: hs+yAuibbMTvGhsn0fvWkEPZyXFmtYFV47qnWpRs0hTw2vt9DGvF0jATa0K2ZrQEmSCrekjMwM
 iSNmcnXUszDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="171201205"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="171201205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:14:05 -0800
IronPort-SDR: lalFpitClpvtGHnMUEgh1yUxTzy7ckyQw+MstcUsm/7HPgfOLdtd3WXoBDpwSsFsrMRoflobkV
 X2HPXSDzYhXw==
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="448633520"
Received: from kairampx-mobl.gar.corp.intel.com ([10.215.194.216])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:14:02 -0800
Message-ID: <df1481e15c591106ba75ed85289b12507cbc8c49.camel@linux.intel.com>
Subject: Re: [PATCH -next] hid/hid-sensor-custom: convert comma to semicolon
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, jikos@kernel.org,
        jic23@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Dec 2020 06:13:58 -0800
In-Reply-To: <20201214133212.3569-1-zhengyongjun3@huawei.com>
References: <20201214133212.3569-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-12-14 at 21:32 +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 4d25577a8573..6c47a2e7623d 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -728,7 +728,7 @@ static int hid_sensor_custom_dev_if_add(struct
> hid_sensor_custom *sensor_inst)
>  
>         sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
>         sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev-
> >dev);
> -       sensor_inst->custom_dev.fops = &hid_sensor_custom_fops,
> +       sensor_inst->custom_dev.fops = &hid_sensor_custom_fops;
>         ret = misc_register(&sensor_inst->custom_dev);
>         if (ret) {
>                 kfifo_free(&sensor_inst->data_fifo);


