Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313C6E97C5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Apr 2023 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjDTO6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Apr 2023 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjDTO6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2023 10:58:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99644C02
        for <linux-iio@vger.kernel.org>; Thu, 20 Apr 2023 07:58:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f178da21afso5308215e9.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Apr 2023 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682002684; x=1684594684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m26NCEtvxnDKnGDOaphgJmSpOW9a1HnF4PVE9T23Ik4=;
        b=D5wQKkPSIsO/e/gN9d8t2lF30U1BTVfcoRBuXrMHbRe/mSBCUC01w1pbKVhNzcdAoc
         QG/fYcM4jlIEPMHJRKcPAvb8l7/R7+vxiUkh1dkAilMvxWOTwfvsmtgBfnvuiNSLRcX4
         AodhDik8Ze1+UgmxwHBoZ7hHgCYSGCCpc1k16pkHspoyiTRDzy+jqPB5ObnW18rnJb2k
         SGCd7v3LWFIuD7VdEg94XSl/EiNKTf4z/WgQEDqfO9hwGMxAegUKBSZX2EBnsi/5dBHX
         BrWl4zKFmAhSHGakxocOK6A39JX74skjmUuRhEjkl3cbVgNxSvU730pSnWj+Ne5TQQPG
         AXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002684; x=1684594684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m26NCEtvxnDKnGDOaphgJmSpOW9a1HnF4PVE9T23Ik4=;
        b=GF1pMJWQ2mnGvD8CKMgHZ5cG5KGIm9Ni33kHFEI146j3tyV6ttqWBQcms6bHmkY8HH
         68U5LGb2CQ5Ur0rqdkgWrHGiqqYIjiDqGzewMqLEInZO7AGwNUbCZJpBeDz6xX6A7xpf
         K5PNXpJxQG3fzXp1RvV+od9FGT5wV/hAubP8GCe4FVN188IgmZ2NiDL8IAZsckiLQRKv
         ty9/xejdFAM73NGCh2hlyujuzK4N6+IB9aBIDdExV1zz/ZkNIctZgQg6o1r2UVIXBeVv
         HvfiZCZXeg8OxzNtEw5aJuaxgsIMMMxb/PdIua26K8sMEv1T+7zfsJWEXH774+ufSDa9
         +y5A==
X-Gm-Message-State: AAQBX9feCwXdJOhzpXGUfYfQ5ZFdGBVDlarSQ/BxswvobCrsvDKHatQs
        mWTQd1Ag6loYsPJ68gp9psm9EQ==
X-Google-Smtp-Source: AKy350alY+YV/JyBnkHXvwjRVGmDc8mU5weLjwGUlMJaA+sj96d5HrEXWEeVSupq72D14Ub+HVRwdQ==
X-Received: by 2002:a05:6000:1c9:b0:2f9:7841:f960 with SMTP id t9-20020a05600001c900b002f97841f960mr1478308wrx.21.1682002684313;
        Thu, 20 Apr 2023 07:58:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6183000000b002faaa9a1721sm2141118wru.58.2023.04.20.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:58:03 -0700 (PDT)
Date:   Thu, 20 Apr 2023 17:58:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: rz-mtu3-cnt: Unlock on error in
 rz_mtu3_count_write()
Message-ID: <25a095bc-2e95-4fc4-80f6-66c4ab402ef9@kili.mountain>
References: <93ec19d1-3b74-4644-9f67-b88c08e79752@kili.mountain>
 <ZEFJcak7Gd/Xygf7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEFJcak7Gd/Xygf7@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 20, 2023 at 10:17:21AM -0400, William Breathitt Gray wrote:
> On Wed, Apr 19, 2023 at 05:23:55PM +0300, Dan Carpenter wrote:
> > The return -ERANGE error paths need to call mutex_unlock(&priv->lock);
> > before returning.
> > 
> > Fixes: 25d21447d896 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> The changes in this patch are for rz_mtu3_count_ceiling_write(), so the
> title of this patch should be fixed.
> 

Huh.  That's weird...  I don't know why I got that wrong.

> > ---
> >  drivers/counter/rz-mtu3-cnt.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> > index a371bab68499..aeadce5e2853 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -358,19 +358,23 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> >  	switch (count->id) {
> >  	case RZ_MTU3_16_BIT_MTU1_CH:
> >  	case RZ_MTU3_16_BIT_MTU2_CH:
> > -		if (ceiling > U16_MAX)
> > -			return -ERANGE;
> > +		if (ceiling > U16_MAX) {
> > +			ret = -ERANGE;
> > +			goto unlock;
> > +		}
> >  		priv->mtu_16bit_max[ch_id] = ceiling;
> >  		break;
> >  	case RZ_MTU3_32_BIT_CH:
> > -		if (ceiling > U32_MAX)
> > -			return -ERANGE;
> > +		if (ceiling > U32_MAX) {
> > +			ret = -ERANGE;
> > +			goto unlock;
> > +		}
> >  		priv->mtu_32bit_max = ceiling;
> >  		break;
> >  	default:
> >  		/* should never reach this path */
> > -		mutex_unlock(&priv->lock);
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		goto unlock;
> >  	}
> 
> Normally, I like "goto unlock" patterns, but I think in this context it
> makes the flow of code confusing with the mix-match of the switch cases;
> default case jumps with a goto, but RZ_MTU3_* cases passes will break,
> yet RZ_MUT3_* failures have a goto path. Rather than a "goto unlock"
> pattern, I'd prefer to see simply mutex_lock() called for these ceiling
> checks. That also has the benefit of reducing the number of changes we
> have to make for this fix.

Sure.  I'll resend.

regards,
dan carpenter

