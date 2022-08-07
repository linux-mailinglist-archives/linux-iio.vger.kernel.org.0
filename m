Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAD58BBB4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiHGPwe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHGPwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:52:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC72648
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:52:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w6so4991877qkf.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Aug 2022 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=t84Ow0VFg/ly2U01bhsHxn2A5dzOSH7taLuo/w36TkU=;
        b=FCVAfewd1vJl+wPjusf91TZvWFSv3c962Y+8rv6zfnC962lJDCWhTEZ6G3zs8XLc4Q
         CSj6P2GxDz1CQzcswCJbm2nNDzGNEvWUPJLR8qQJ1I3O+KaWXdxv4kHItZzSZDddwl+e
         V4FkeRn6mvbIgLqfchN3ti3TGuYgnVtPN6zcsmpcB2Fk/jme/5vrL4iYu5bwzIMvBLEn
         tU8wdNLQ+l5tjH3s/12oT4No3Vtm3/iqWh4dauktTBd8uIwKOdzqBgHvuEZtFfKRBI1S
         J5XFbl/Nj7p37xztKLY4q8twenXZr8LJfk7WgH7aWf1VTGC07Y/MYYA8fCP85VluPTHi
         JSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=t84Ow0VFg/ly2U01bhsHxn2A5dzOSH7taLuo/w36TkU=;
        b=oXXpWfSeGayb8hsGgp7udAne9FqVRmyxSSoiUMXhxxDq9S3B+PwgRm9w/e2Kx4bHLG
         MehUbyUFYFxMd5BIX5R6eEdins2aP5qTwOnv/0fbjApzCnEYiNaExSdJzw4r8dHPSC7f
         CYjaMuxaoYU3RPbgidpo55WoIevzomMaFrAyv1Xqu2bPYyYKn3w9ZSgGsXxCdkrIU8r5
         o3UOPBzgNAqilM9dw6SvJ9ttQcbb+yg5sLUpj0Rleq+mBm5TnR5Yq9veyA+YVEko+0ao
         CvpnFPogVPpQvaV6rEWRxry1yN326heamzLob3vvHGoS11RJr9/v5Ncxz51CUzP3A8MU
         i6Qg==
X-Gm-Message-State: ACgBeo1bAsm5PgukttCX9tDwSnPK3jn+XEgysGmWifLW+D+3KZLBm99t
        i/7FygTzNmRUzIYUm832DKbEabgAwP8=
X-Google-Smtp-Source: AA6agR6xhzpYF/Pmgux0Q3PjqEtXmCkdUMu7lWeUN1QHZHQNaT+xr4KDr35VLLa2r3qb327QgGgTuQ==
X-Received: by 2002:a05:620a:1706:b0:6b9:234:f735 with SMTP id az6-20020a05620a170600b006b90234f735mr11654988qkb.623.1659887551506;
        Sun, 07 Aug 2022 08:52:31 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id h126-20020a375384000000b006b5cb0c512asm7123962qkb.101.2022.08.07.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 08:52:30 -0700 (PDT)
Date:   Sun, 7 Aug 2022 11:52:29 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: test: Mark file local structure arrays static.
Message-ID: <Yu/fvT62LkY0b94V@shaak>
References: <20220807145457.646062-1-jic23@kernel.org>
 <20220807145457.646062-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145457.646062-2-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 07, 2022 at 03:54:56PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Warning cleanup:
>   drivers/iio/test/iio-test-rescale.c:32:30: warning: symbol 'scale_cases' was not declared. Should it be static?
>   drivers/iio/test/iio-test-rescale.c:480:30: warning: symbol 'offset_cases' was not declared. Should it be static?
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Liam Beguin <liambeguin@gmail.com>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/iio/test/iio-test-rescale.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
> index cc782ccff880..31ee55a6faed 100644
> --- a/drivers/iio/test/iio-test-rescale.c
> +++ b/drivers/iio/test/iio-test-rescale.c
> @@ -29,7 +29,7 @@ struct rescale_tc_data {
>  	const char *expected_off;
>  };
>  
> -const struct rescale_tc_data scale_cases[] = {
> +static const struct rescale_tc_data scale_cases[] = {
>  	/*
>  	 * Typical use cases
>  	 */
> @@ -477,7 +477,7 @@ const struct rescale_tc_data scale_cases[] = {
>  	},
>  };
>  
> -const struct rescale_tc_data offset_cases[] = {
> +static const struct rescale_tc_data offset_cases[] = {
>  	/*
>  	 * Typical use cases
>  	 */
> -- 
> 2.37.1
> 
