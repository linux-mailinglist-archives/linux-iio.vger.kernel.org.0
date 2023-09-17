Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A577A3540
	for <lists+linux-iio@lfdr.de>; Sun, 17 Sep 2023 12:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIQK4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjIQK4e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 06:56:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BE19A;
        Sun, 17 Sep 2023 03:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DEC433C7;
        Sun, 17 Sep 2023 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694948186;
        bh=qg0JuTDvZQp7kvNhNDcg/xEyBxciHuYdnE17kH/AWjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwncRpMgUqStumHZrwQeA4BBD2GUi7dArXSFaHbPzOhaXN7QbSeM5ul4VUQuoklpt
         2zVjoe7vdGQg6QNMeRpHJNMl+BXfzhGS+40Rh/qKVFXMOCa+biRahw6GM8Bmq6wy0m
         bOyr/6j/srsEmKUw69k2aHpUQHit0JeKDEfBKCyFzMGAu/cRfR9LVX5NhO4HkCKIKd
         ZGvat35QiC+Wkscv9H88Q0nJAD5BvtGimBRDC17yOgi1lfKEPh/zcua2O0d1sDYI/z
         N09/4treyb//55eg/ie3hUI3JQpnKQIpLWx3jeMdwMvf9dbByCx3kYAH+TxDAKYHg5
         DvTYRyAu92GjQ==
Date:   Sun, 17 Sep 2023 11:56:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        <linux-iio@vger.kernel.org>
Cc:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH 1/8] iio: hid-sensor-als: Use channel index to support
 more hub attributes
Message-ID: <20230917115618.1659a36c@jic23-huawei>
In-Reply-To: <20230915051703.1689578-2-Basavaraj.Natikar@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
        <20230915051703.1689578-2-Basavaraj.Natikar@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Sep 2023 10:46:56 +0530
Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:

> Sensor hub attributes can be extended to support more channels. So in
> order to support more sensor hub attributes for ALS use channel index to
> get specific sensor hub attributes.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Hi Basavaraj,

> ---
>  drivers/iio/light/hid-sensor-als.c | 38 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index eb1aedad7edc..48879e233aec 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -24,7 +24,7 @@ enum {
>  struct als_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
> -	struct hid_sensor_hub_attribute_info als_illum;
> +	struct hid_sensor_hub_attribute_info als_illum[CHANNEL_SCAN_INDEX_MAX];

If being used for other channels, probably want to rename it as no longer
als_*illum*
>  	struct {
>  		u32 illum[CHANNEL_SCAN_INDEX_MAX];
>  		u64 timestamp __aligned(8);
> @@ -99,8 +99,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->scan_index) {
>  		case  CHANNEL_SCAN_INDEX_INTENSITY:
>  		case  CHANNEL_SCAN_INDEX_ILLUM:
> -			report_id = als_state->als_illum.report_id;
> -			min = als_state->als_illum.logical_minimum;
> +			report_id = als_state->als_illum[chan->scan_index].report_id;
> +			min = als_state->als_illum[chan->scan_index].logical_minimum;
>  			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
>  			break;
>  		default:
> @@ -242,23 +242,23 @@ static int als_parse_report(struct platform_device *pdev,
>  				struct als_state *st)
>  {
>  	int ret;
> +	int i;
> +
> +	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {

> +		ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
> +							  HID_USAGE_SENSOR_LIGHT_ILLUM,
> +							  &st->als_illum[i]);

I would call out either as a comment here or in the patch description that we repeat
the same reading for the two existing channels and hence whilst we store them in
separate entries things continue to work as before where there was just one entry.

> +		if (ret < 0)
> +			return ret;
> +		als_adjust_channel_bit_mask(channels, i, st->als_illum[i].size);
> +
> +		dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[i].index,
> +			st->als_illum[i].report_id);
> +	}
>  
> -	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
> -			usage_id,
> -			HID_USAGE_SENSOR_LIGHT_ILLUM,
> -			&st->als_illum);
> -	if (ret < 0)
> -		return ret;
> -	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_INTENSITY,
> -				    st->als_illum.size);
> -	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_ILLUM,
> -					st->als_illum.size);
> -
> -	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
> -			st->als_illum.report_id);
> -
> -	st->scale_precision = hid_sensor_format_scale(usage_id, &st->als_illum,
> -				&st->scale_pre_decml, &st->scale_post_decml);
> +	st->scale_precision = hid_sensor_format_scale(usage_id,
> +						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
> +						      &st->scale_pre_decml, &st->scale_post_decml);

Keep line lengths shorter anywhere it doesn't hurt readability.  Whilst the hard limit has
gone up we still prefer to keep under 80chars where it is easy to do.
Sometimes that means relaxing the alignment with opening bracket.

>  
>  	return ret;
>  }

