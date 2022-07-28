Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D0584865
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiG1Wss (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 18:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiG1Wsr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 18:48:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAA51A05;
        Thu, 28 Jul 2022 15:48:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31e47ac84daso34837127b3.0;
        Thu, 28 Jul 2022 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbbIwNHYA5fQMBY7syKbTH1UwgoGIprYwzTKm582+h0=;
        b=TlEJ6Ruu4n0OcOMH/kNl+yUxKyVkTDjntX+0bKHpRUyDzlHVanmpZP2JTZRyjeGbqr
         h9QMOT35fNBH+EMy/HUeZF/EYb/TPovcKSOB3q0fqXWtjfp4HnJBw2F9CY+eon8eV1Jf
         Ul6t5tPQP5QhXYftUWF/0hEO56pz1fsppXMMQzfap0hWGCOHLOy3SISAioovIqtlS8Fw
         cLvI+Az7YceG8PAEoYenIsVreiAh1MMlBTJbFMaaSTIX3RWAoKJztTvbH95/F1XhRnC5
         vTSc6F1r88SyDur7K7AQ7tbFy6kfE/9PQqBOQAj+muPHKdenSqBYss/jb2kYj+Pgv//N
         GAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbbIwNHYA5fQMBY7syKbTH1UwgoGIprYwzTKm582+h0=;
        b=y6kLpoOQK2+yXoeA6/aJteNg2sC3+zj3XJPhvGlBs1QGZnK89lInckF0vqUsvAhm0S
         yhKsQ1kvHzygyQGPm21xvk1r1fYN7+CBo6NPXdyufYgQRUolV8f+FvZNNG6aE/lh4bBP
         3kupS4Uz3LaBGFPqgMZUCrXeqQIPY4LzjaCWSrlryrVLZ1f9UFEScfqu/T2QLxrP4baf
         sQ5KD17RosvWkztAwwMsxZdGOR9O/PtLjx999VAz/XiLdV/zH89Otdi4FlduGYz/AOnK
         5/4ZtUCDFBS/6IHGLokulCXbL1XIUHm3wmYlZJqDhV3JY5WhK+FgaAGoQ8kgeDa8pvQH
         vUjg==
X-Gm-Message-State: ACgBeo36ujnK17gK/lvyNzrzBEM2ZYVsRgAzwmNpoLB5AIoBVoGPPgeT
        w1mFehvprOMNg+p/k0i+jVEqVHS4a7OomFSXyQs=
X-Google-Smtp-Source: AA6agR6/s/iZvfkJGZABz6Eu7j8VuDO5qbShjSiqVGx4ORVST12Al5dEVLSCk1fAyA9mOHgfJmwp/hWxQOFxJ5Kew9k=
X-Received: by 2002:a81:85c5:0:b0:31c:1f50:1bbb with SMTP id
 v188-20020a8185c5000000b0031c1f501bbbmr819183ywf.3.1659048524769; Thu, 28 Jul
 2022 15:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <202207190634.ToyhlXSz-lkp@intel.com> <0551a3ad-8c42-78fe-5b50-ebbc003e55e6@intel.com>
 <CANRwn3R48rvwnygdyKhmFE8wD+BCCHrTWa-M=uTvpnK5Jo3vww@mail.gmail.com>
 <CANRwn3Tgumg-mZ9sV=8AXevag9z2s=mTF4qqZW2KenDmc9b1wQ@mail.gmail.com> <CAHp75VfFrkDLOC2+5WUmVGBLfoxVbDzJKyLN0+Z+XrZzpkYDkQ@mail.gmail.com>
In-Reply-To: <CAHp75VfFrkDLOC2+5WUmVGBLfoxVbDzJKyLN0+Z+XrZzpkYDkQ@mail.gmail.com>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Thu, 28 Jul 2022 15:48:59 -0700
Message-ID: <CANRwn3SH2Z5n5so4FcymzgN-KAciHGo=tuXUheVttc2+vQeRqg@mail.gmail.com>
Subject: Re: [PATCH] i2c: Use u8 type in i2c transfer calls
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Ping Cheng <pinglinux@gmail.com>,
        "Tobita, Tatsunosuke" <tatsunosuke.tobita@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 28, 2022 at 1:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 28, 2022 at 4:30 PM Jason Gerecke <killertofu@gmail.com> wrote:
> > On Wed, Jul 20, 2022 at 12:01 PM Jason Gerecke <killertofu@gmail.com> wrote:
> > > On Tue, Jul 19, 2022 at 5:21 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> > > Writing a patch to fix the new warnings generated by my I2C patch is
> > > simple enough, but I'd like some help coordinating getting both
> > > patches landed. Should I wait for the I2C patch to land in "for-next"
> > > before sending the IIO fix, or would it be preferred to send the IIO
> > > fix right now so that both patches can be reviewed simultaneously?
> >
> > It's been pretty quiet, so asking again for any thoughts on how to
> > best address this tangle...
>
> The rule of thumb is not to introduce an additional warning or compile error.
> I haven't looked deeply into this case, but it smells to me as if you need a new
> version of your initial patch that includes a fix to IIO.
>
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks! Since the patch would touch both IIO and I2C I assume I would
submit it to both mailinglists. And that whichever maintainer gets to
it first would just give their Reviewed-by (if all looks good) and the
second applies the Signed-off-by and handles the merge?

I'll work on the updated combined patch...

Jason
