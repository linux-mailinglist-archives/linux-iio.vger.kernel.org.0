Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D783042BC2D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhJMJzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbhJMJxR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 05:53:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9CC061746;
        Wed, 13 Oct 2021 02:51:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d3so7783084edp.3;
        Wed, 13 Oct 2021 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPBt/4KUoaneMkVHcjVEd+UeNw6KJR5ixhmRH7r0XSE=;
        b=Pw4XojORQxY2ifs+HKqaiQpiPCTMywJyV4fa+uVdzb6vlxETKfuON4mMIZooLlmBd+
         fvkMtopmTnBUzyMaanYlY6axXdckNH58/VTZYu8Sa1bYS5Bzwe3eWbEKBb66eWfyJ+ml
         ZuTab+wEmM/byeHYymPx5S7nWgITAGUysLRGdvT19lxiYLf40iE9mTGvAQs/UNM+sCj1
         KrtpLtGaaWO+HmNP73oldPb5YhLtlo285WpbFwjWQ4ypqHIaSKipsJbu+NeUbryPdEw6
         kPe40PUL11qlWjfH0KWEQVutjav67zREqdekxGL9AftcSfAD4dgX1j4rjPOSseZ+xofv
         RNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPBt/4KUoaneMkVHcjVEd+UeNw6KJR5ixhmRH7r0XSE=;
        b=3pCbSNR+8R56aCKQ9M97xNz70FSx1qvdisMJMavofw0CPsIPUlAOkRjScu+2hwyPRa
         ouxTppMpHhL6XuQqa6WU87fbxHSNMNkqqSsWbsxAHsJxSmK1VdvIjfx98cWsffGku+XD
         Rlr/TWw9/tOScQJ7Qs4dzCqktBqnbfOU5yYqqrQCd3gZ4/G+LoIHvK98OepBZEBYkdjL
         d8rh4wqaTZXAo296LPj826/Q7+HX+j/wPFUlBtTmoZtB12/sB6J235E6HXrmR7dMHN3n
         0gQtvBVMV85tV+/cMDpEmwrgpke/VU2ZX3WrRqZe8D+TObpPO77myVPsk4EUFT/iY13J
         RbLA==
X-Gm-Message-State: AOAM5305VD8pxkKuiAG8LIxs7GLSzm2sdiF/46d3DlaWPVnrX1tK5Ayc
        1LyQ80hAysibJU7AuVXj7CX3wyCd3p+PszkCous=
X-Google-Smtp-Source: ABdhPJxf86UVc3m9pU19cXQgmJcDmqtB5+RigtFoifMlf8XDpRtGJZh9Cs+CRPHeAxtdOqVnxxfQOuvh90SQW+kC+Vk=
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr8211050edx.224.1634118672857;
 Wed, 13 Oct 2021 02:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
 <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
 <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
 <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
 <CAHp75Vdx1=q=5sNkn9o=mqnufxYiXnssmMJtXw9goFskGijc1w@mail.gmail.com>
 <04c752b5-3814-34d0-82e4-9d0d46af433f@huawei.com> <CAHp75VeoOj0bvGBO3PaMMD4sQTRF=rpxxLQXKeyFucpvofbV1w@mail.gmail.com>
In-Reply-To: <CAHp75VeoOj0bvGBO3PaMMD4sQTRF=rpxxLQXKeyFucpvofbV1w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Oct 2021 12:50:36 +0300
Message-ID: <CAHp75VfRH3Z=-j=GVqzpuPGc5sPet+Jdd6WqnGmhTLW=Gm2VaQ@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 13, 2021 at 12:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Oct 13, 2021 at 12:17 PM Yang Yingliang
> <yangyingliang@huawei.com> wrote:

> I could send a v2 on your behalf.

Looking into code further I think that your patch is good as is, see
v2 I have just sent.

-- 
With Best Regards,
Andy Shevchenko
