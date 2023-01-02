Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E065B541
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jan 2023 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjABQnH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Jan 2023 11:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABQnG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2023 11:43:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57ADDFB;
        Mon,  2 Jan 2023 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672677784; x=1704213784;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnxJ6XmSgkvongoJ93IRsYTokk5mqjqpPWZx8tLs2R8=;
  b=aabqG//Px1DlmFt35IE/YjpzDdZ9vUoS0Ch8LIFiLxwfc85+uN4/J7IH
   UuCVlmvS8GUf9DKeOe9EWyD0bfybmkauzZw6m7aJey42B9E+sR9DIltKs
   8eiPXpyA2Y22bvGYRolVg4OVIQEkQRSiFhcP469HHjSSFxt1iRVRFmzP8
   KmhmcSlySw4GBWoijiq1kZOSMVv9oIfGFCunIN54Dw6vmxBjvhMZ+Bd7b
   uI8L/zjkIV/9w021cKFtXD3xD/+aDcZcH3lua6h6HbiIcePMvJ4zBQIiT
   EWy4T/gTpg+P31mObv7tyb4OqMcMFi8aptWNMk0r0HkV8SG5RnBeYf6zE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="323503498"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="323503498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:43:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="656519333"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="656519333"
Received: from mkumar2-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.252.140.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:43:03 -0800
Message-ID: <19d6dc836b4c843e42387dc1968ecbb63811ac16.camel@linux.intel.com>
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Mon, 02 Jan 2023 08:43:03 -0800
In-Reply-To: <20221222120742.232087-1-p.jungkamp@gmx.net>
References: <20221222120742.232087-1-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2022-12-22 at 13:07 +0100, Philipp Jungkamp wrote:
> The hid-sensor-prox returned an empty string on sysfs
> in_proximity_scale
> read. This is due to the the drivers reporting it's scale from an
> internal value which is never changed from zero.
> 
> Try to query the scale of the HID sensor using
> hid_sensor_format_scale.

By spec there is no unit for this attribute:

"
An application-level or physical collection that identifies
a device that detects human presence (Boolean yes or no).
"

There is no use of calling hid_sensor_format_scale() as there is no
conversion. With the call this is setting scale_pre_decml to 1.

Better to set scale_pre_decml to 1 instead of calling
hid_sensor_format_scale(), which gives wrong impression that we are
converting to some scale.

Thanks,
Srinivas

> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> ---
> Hello,
> 
> While trying to utilize hid_sensor_prox driver I noticed this
> problem.
> Should this be part of the branch created for the other patch series
> I
> have submitted?
> See:
> https://lore.kernel.org/linux-iio/nycvar.YFH.7.76.2212201525010.9000@cbobk.fhfr.pm/T/#u
> 
> Regards,
> Philipp Jungkamp
> 
>  drivers/iio/light/hid-sensor-prox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..3322f8e56f41 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -222,6 +222,9 @@ static int prox_parse_report(struct
> platform_device *pdev,
>         dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
>                         st->prox_attr.report_id);
> 
> +       st->scale_precision = hid_sensor_format_scale(usage_id, &st-
> >prox_attr,
> +                               &st->scale_pre_decml, &st-
> >scale_post_decml);
> +
>         return ret;
>  }
> 
> --
> 2.39.0
> 

