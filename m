Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78221A4FF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGIQmU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQmU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 12:42:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FADCC08C5CE;
        Thu,  9 Jul 2020 09:42:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so1238263pfq.11;
        Thu, 09 Jul 2020 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOR+9StZCul8bBrAKPaQ/GhvI1UNu403RqQyrxCjABU=;
        b=ZhpHog7Tu/i8/tgWaUMQD64GTbdNqncLqvCVWer/FpGbv/EGa9YX6Mw8GPxHjeAi85
         3wyc7Yutd6qnfW7sv/rL9V61c2QcD86CkVOU1Ouu/dLe3ophdzSTtlPV0uBeK+HI0Ucv
         0ttI8oLisoICRbDk8EqkNv4v4dwZrfw4+vodF87rEMAjxBwMXy/xcA86xipt0GuTSuyN
         pNCDDySpI45N3ubEhJSxcOmrd91DxJv6bHPlhHTYqf43nZWICfMgMS8YyujkcQ/HaHVA
         +KY9aIHp+HTxSFjtQt0QyMjFa0x7YNz5Y+DwquUysDNT1ryIjKq4AXhiM1IrqBS7r6uK
         hO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOR+9StZCul8bBrAKPaQ/GhvI1UNu403RqQyrxCjABU=;
        b=ldqwir1yjigJcG4nUytyqT2Obrdt/vO7uvwMM+28xkc+JVLBNy45TJcYmqx5amLb4Y
         HsQQ0mFkr07sHvrJkD6e5461JU8kzOz4F0GLBdbGCI7V1QGlhxU+zYKydPCMFj3JhMD6
         qfSlOQEHWzaOJiDU6R3OiLluN31AsTY5OFpKCCVJTRzfBB2TiZM/5DUH5JKyHkCYq/I6
         ta1+feweJSwubsPCGz3sfYzB1TmUvRBbnt4mkeYqBygLtbp3whKS9q5160Y4o/PCYZik
         2DrGOY/ZuJrZ9aryy80L79JANwouv7gyHxcW8WbpwEv049KTbpouM9+QJt/wE2QwSkQp
         RKgg==
X-Gm-Message-State: AOAM53114vuq7gcTC2kdvRDV1Mjc/i01E4q5MKGgdNVPZglbsjITqn1k
        KFjG4A9CPFmpfM44AN09ARFGVtEKV/xMYYfteUk=
X-Google-Smtp-Source: ABdhPJwrdtkru6pbIR5By3jq9i0VIVHJXJHGbH/RZB1O3LCipYHDkjz6NIdmtD5Y49jn25sM2VgPcpS5g7X79nd4N70=
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr23296458pfu.36.1594312939767;
 Thu, 09 Jul 2020 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200709152200.10039-1-contact@artur-rojek.eu>
 <CAHp75VcwgL8pH+pH9TnsuwbWr=wSFu37sX8sTkbkfk+iBv7Jng@mail.gmail.com> <9865deba48fdb1b5bb522ae7cabef7bc@artur-rojek.eu>
In-Reply-To: <9865deba48fdb1b5bb522ae7cabef7bc@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 19:42:03 +0300
Message-ID: <CAHp75Vd51z_MDRno_wSXpSS9zj0kCntmFqYSHbOr-dds7NhPsw@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 9, 2020 at 7:05 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Hey Andy,
>
> On 2020-07-09 17:43, Andy Shevchenko wrote:
> > On Thu, Jul 9, 2020 at 6:22 PM Artur Rojek <contact@artur-rojek.eu>
> > wrote:
> >>
> >> Hi all,
> >>
> >> v8 of this patchset introduces some structural changes, which I deemed
> >> worthy highlighting here:
> >
> > Can you remind me if I gave you tags on the previous version?
> I received no tags from you on this patchset so far.

Thanks for reminding me!



-- 
With Best Regards,
Andy Shevchenko
