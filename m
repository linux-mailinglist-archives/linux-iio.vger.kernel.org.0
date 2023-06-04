Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A5721642
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jun 2023 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjFDLGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jun 2023 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDLGR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2023 07:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F0CF
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 04:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F5460D24
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 11:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B055C433D2;
        Sun,  4 Jun 2023 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685876776;
        bh=0KMvY+LYoM5WQzsT+xWsrQMqF8Mn+qkNdqfA1DFQFs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYljRhylxAYDMyxQ3hkwEc42i/UmX9XSjZkiHYylho67uw47+3kq7xtnjY/ey+9Yd
         CVzS9n4nFy5YCVRytaYk5h/HoH7qYIlStua1aj9M5dCdwrHWzeeRENRYiagMjTEEYN
         PD+fapzem9+PgaQgrR92PPXn2cEx2HBUTQjqp7FBHHkCilaDK9Y5q4il/v05LZYY5V
         Qu09MBqcKqX08+FVvqcpgqNg1aPUQ9Zh1Md5XWfErEvCpoq6L2cdUzpibFV+Dv/D2K
         slgRbPOf0QH+zlmpBXmvXQP20Ume6NWHblRBCaA7tQSkp3lj/2ZnObefNdD2ulPAwX
         J9+vxzGJD2MqQ==
Date:   Sun, 4 Jun 2023 12:06:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 3/4] iio: make invensense timestamp module generic
Message-ID: <20230604120612.729f406d@jic23-huawei>
In-Reply-To: <20230531142513.48507-4-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-4-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 May 2023 14:25:12 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Rename common module to inv_sensors_timestamp, add configuration
> at init (chip internal clock, acceptable jitter, ...) and update
> inv_icm42600 driver integration.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Docs update needed below.



> diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
> new file mode 100644
> index 000000000000..23440bc7322c
> --- /dev/null
> +++ b/include/linux/iio/common/inv_sensors_timestamp.h

> +
> +/**
> + * struct inv_sensors_timestamp - timestamp management states
> + * @chip:		chip internal characteristics
> + * @it:			interrupts interval timestamps
> + * @timestamp:		store last timestamp for computing next data timestamp
> + * @mult:		current internal period multiplier
> + * @new_mult:		new set internal period multiplier (not yet effective)
> + * @period:		measured current period of the sensor
> + * @chip_period:	accumulator for computing internal chip period

Docs need an update.

> + */
> +struct inv_sensors_timestamp {
> +	struct inv_sensors_timestamp_chip chip;
> +	uint32_t min_period;
> +	uint32_t max_period;
> +	struct inv_sensors_timestamp_interval it;
> +	int64_t timestamp;
> +	uint32_t mult;
> +	uint32_t new_mult;
> +	uint32_t period;
> +	struct inv_sensors_timestamp_acc chip_period;
> +};
> +


