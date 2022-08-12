Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538495916D4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHLVtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHLVtl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:49:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8EB0892;
        Fri, 12 Aug 2022 14:49:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j17so1752827qtp.12;
        Fri, 12 Aug 2022 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nOBGNe0K8Dv1II0YhQ6IBHsguDss5WydwMDeWDaNg9g=;
        b=D0lGpXLG028uGrzrag9IBU+wZG4q4pLwhgDh5zbUJ+4+VxpjzR9R40iJM2J2m2sL93
         +5G/WbtroB6SMgDiu2IlIk/73M4kWfel9/IJ2o1poeQ3iuoXVhanu7Gn2kYzPxUnu0xn
         5yY8bUajlEV6QbDALTsx5x+Kzgfkt9in1vEdD7GFCdlj9PwPVJbCmDMTxtqo0brCaxfU
         KaEIqedUEDLuLYZU1GQbr5ziVucdhVhzMS0KzfV50l0TwnWi+oL2mTuoqIFmMwFxsidf
         7SX6CmCucM4cX9W+oCsybgIhHqP6Rfq27uWSzUo75zJUnNRtH93sHntk4iD/v2GorCsh
         iyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nOBGNe0K8Dv1II0YhQ6IBHsguDss5WydwMDeWDaNg9g=;
        b=qWCKEg3LZjRrYpRzZcgxyQejQ+8hgXtmTU1k8Of5fthWVlfxtFaO03a1kn7pLz8KuI
         FN6paXYWv0Zs1iETBm5lLXOGvhd6Zyrlj+lNBSJo3iQ+xf5aKLaDEn8JZbEOL42zM70O
         vSVzUDo2j317/IshPR8Wq47GKERaki0ZjKbhmId5Hl9GWdOySFambdkmnq/UtOOfzdgq
         RqFGFE+yyHrthgjd0DBSle5NWJssTLwbf1uDlcBLZKHfd+1rLQ0uNAWv8ZDjw2kUvp5e
         2DpNIQxI0F4i/L7Pi2mG0GLJ88FEIgloxZ3HigkzBmS9Q2RbMC8Nl339gyXMzcx0Tcs9
         mBNQ==
X-Gm-Message-State: ACgBeo184r5mwMBu4pHeVZ2DpIEu/nWtn64HOc42+XwQx3KZuvREENIW
        5Qtuq0/XjcRxepZE1TRWBgb60hSf15fCiPSYtk8=
X-Google-Smtp-Source: AA6agR4VurPHqlXqGvwOoq7dUetTwkrIGniaguB2pE+60F9SCFGDJ8sgWINfZgkEFDOh71zHNMVqaeo4XTSA91wq8Io=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr3454864qtx.481.1660340980224; Fri, 12
 Aug 2022 14:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <a7bc9d7a7bb12a76fb217a1709fb09abd2b45892.1659909060.git.jahau@rocketmail.com>
 <CAHp75VegA6zzvQXEi_9-K3832o+j48Af3X8LivYY47Xav+w-xQ@mail.gmail.com>
 <850de937-8fe6-ebce-4e9d-35a617c3ade6@rocketmail.com> <CACRpkdbXNE17cOM2Kd+mUf7JMefZE+NBWxyHt4vkQWEF_3BtjA@mail.gmail.com>
In-Reply-To: <CACRpkdbXNE17cOM2Kd+mUf7JMefZE+NBWxyHt4vkQWEF_3BtjA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Aug 2022 00:49:04 +0300
Message-ID: <CAHp75VcBN+pR61i1KjjFpjDaZJUvFHHS0eKi__qf8+9omMLaeQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] iio: magnetometer: yas530: Add YAS537 variant
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 12:43 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Aug 10, 2022 at 1:41 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> > On 08.08.22 13:47, Andy Shevchenko wrote:
>
> > > P.S. Do you see now how your series and the end result become better?
> >
> > The driver improves. Though we kind of get lost in details, I have the
> > impression we could go on like this forever.
>
> I think at one point Jonathan mentioned the phenomenon "perfect is the
> enemy of good", which even has its own Wikipedia article:
> https://en.wikipedia.org/wiki/Perfect_is_the_enemy_of_good
>
> When I feel (for some intuitive definition of "feeling") that a patch
> series to my subsystem is getting over-reviewed, I usually just
> merge it and tell everyone involved to write and/or request
> additional patches if they are troubled by the result. It's a fine line,
> admittedly, it's not like I can define the trigger point.

The problem here is that a new round of review was triggered by a
build bot that can't compile it with a Clang which follows C standard,
but doesn't have sugar to it. Otherwise series was ready to be merged
and can be improved later on.


-- 
With Best Regards,
Andy Shevchenko
