Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69FC66AC91
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjANQTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 11:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjANQTK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 11:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622C83D5
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 08:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308E460B43
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 16:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2145C433D2;
        Sat, 14 Jan 2023 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713148;
        bh=9QCiOGcWXmQgWrsH3/HSnQ+J2C8dOWEjlsjxJbTdPyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nrWmDbBX+6QU/DMJZ8rHHjBfvY9Gufhrnke1piYNpr5xHxrU5CSXOEMDcjYc9Xi08
         4ycnVwnmW+VQc6n0dnfX0PnHFRLHTPu+nX/p6t10NExuYi+GPTM/cpYzjRnU16/Jt/
         1DH1D9XsXshj74lHqMkFzTG37dRztjsXSHBDdKQGDPCxk4tNUswxjvEEA/Y4WxnxL9
         QAh+RO+h0Np2XGY1NS8MOfdXn1yyrIPc3+rfZZ/jG8BhyNKN3NObig/rJx68ISbas+
         BxCJhJrnbFts5vg27WhlKeqHBOQjX/J4w52l/6o2qAVQlOH/lZblcqPW+RETbb1J07
         aD8xZPK/i5KgQ==
Date:   Sat, 14 Jan 2023 16:32:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Subject: Re: iio: hid: fix the retval in gyro_3d_capture_sample
Message-ID: <20230114163245.33a9f7fa@jic23-huawei>
In-Reply-To: <7c1809dc74eb2f58a20595f4d02e76934f8e9219.camel@intel.com>
References: <7c1809dc74eb2f58a20595f4d02e76934f8e9219.camel@intel.com>
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

On Wed, 11 Jan 2023 14:24:25 +0200
Dmitry Perchanov <dmitry.perchanov@intel.com> wrote:

> Return value should be zero for success.
> This was forgotten for timestamp feature.
> Verified on RealSense cameras.
> 
> Fixes: 4648cbd8fb92 ("iio: hid-sensor-gyro-3d: Add timestamp channel")
> 
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
Applied with patch description white space tidied up (wrap at 75 chars,
not blank lines in tags block).

Applied to the fixes-togreg branch of iio.git and marked for stable
inclusion.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 8f0ad022c..698c50da1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -231,6 +231,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		gyro_state->timestamp =
>  			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
>  						     *(s64 *)raw_data);
> +		ret = 0;
>  	break;
>  	default:
>  		break;

