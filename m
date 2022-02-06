Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC44AB02E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiBFP0K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 10:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFP0J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 10:26:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4BCC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 07:26:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48A9EB80D87
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 15:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC79C340E9;
        Sun,  6 Feb 2022 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644161162;
        bh=vVhyOlWfp536sFcJGCQFVGaIdcZ9C7hKStt2y//H37o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hivtDsupRdivqMZI+iID1VbFqh5LqMOAILgGoZF8mJfnPGgQYk8vMwxrXcTV9Ix2y
         XNR5pEMihgagRE4JQtZKJnhjw4URdCN+HMioOYIpMSKG3K19myZv921Xh/5MyALdsz
         v8FirMoo1+D7G1ryeznNUygis9e8Si7Q2iOUjURCLbeOFWPTGly+pfRF804UVNYeoU
         oRgjhNZzGEO/Bo+TWfVwSk1TpslqmdPn9QiFXcr+0q3PTs1UYJYIMFiBb3QfuNvaVI
         UBNUKca6RRcVZVTntNg1cnEcAVYaMJkegyB36jE3RoxA0rSZ+821Tg7pH1QyxNjEtB
         Bq02SNYT3dS5g==
Date:   Sun, 6 Feb 2022 15:32:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: wait for settling time in
 st_lsm6dsx_read_oneshot
Message-ID: <20220206153233.45a96a9c@jic23-huawei>
In-Reply-To: <b41ebda5535895298716c76d939f9f165fcd2d13.1644098120.git.lorenzo@kernel.org>
References: <b41ebda5535895298716c76d939f9f165fcd2d13.1644098120.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Feb 2022 22:57:42 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> We need to wait for sensor settling time (~ 3/ODR) before reading data
> in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.
> 
> Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")
> Reported-by: Mario Tesi <mario.tesi@st.com>
> Tested-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Thanks for the quick update.

Applied to the fixes-togreg branch of iio.git and marked for stable.

> ---
> Changes since v1:
> - add missing Fixes tag.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 727b4b6ac696..93f0c6bce502 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	if (err < 0)
>  		return err;
>  
> +	/*
> +	 * we need to wait for sensor settling time before
> +	 * reading data in order to avoid corrupted samples
> +	 */
>  	delay = 1000000000 / sensor->odr;
> -	usleep_range(delay, 2 * delay);
> +	usleep_range(3 * delay, 4 * delay);
>  
>  	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
>  	if (err < 0)

