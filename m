Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC89E66AC8F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjANQRM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjANQRJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 11:17:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8183EB
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 08:17:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4BC60B43
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 16:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF0BC433D2;
        Sat, 14 Jan 2023 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713024;
        bh=KXtaHIqY1C60VX/sB/L+CgXAGL2L5qH3IF4nw+o8gL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bc0wSUEzPFgblFV6NhZWliXQPk8u8ev8851H7lURr7n6nk1av7J/iVXlRha56j9s2
         FkgHqh7YQ5KuCHoh06PCdm80C/dKaJKXlp5mBu89fPTFet5JkOzEutEN8XbixLaXsD
         PBiOgqpGG+NtUXL6VGnabvhCi31e0eHa5/kAO3uLnMRFQv4kHu17qBlDr5HwqdjobL
         wk5CcERmNzfjybuAAGLbTs9jHxXlzh25CZu7GBOx3dRdKew8hP9lQWiDM8fksD5YaF
         WMTGqLlNAFPcMIYMcPgAJR/uwjV/znlDd3fv9anA9S2xUfgw2C2red8YZjyFwGWLlP
         aTUJ7616xb5iA==
Date:   Sat, 14 Jan 2023 16:30:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Subject: Re: [PATCH] iio: hid: fix the retval in accel_3d_capture_sample
Message-ID: <20230114163042.55f89318@jic23-huawei>
In-Reply-To: <a6dc426498221c81fa71045b41adf782ebd42136.camel@intel.com>
References: <a6dc426498221c81fa71045b41adf782ebd42136.camel@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Jan 2023 14:22:10 +0200
Dmitry Perchanov <dmitry.perchanov@intel.com> wrote:

> Return value should be zero for success.
> This was forgotten for timestamp feature.
> Verified on RealSense cameras.
> 
> Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")
> 

All tags need to be in one block with no blank lines.   I've fixed
this up whilst applying.  Applied to the fixes-togreg branch of iio.git.

Thanks

Jonathan


> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index a2def6f93..5eac7ea19 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -280,6 +280,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  			hid_sensor_convert_timestamp(
>  					&accel_state->common_attributes,
>  					*(int64_t *)raw_data);
> +		ret = 0;
>  	break;
>  	default:
>  		break;

