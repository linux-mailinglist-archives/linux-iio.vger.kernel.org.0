Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A056E74D3DA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jul 2023 12:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGJKuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jul 2023 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJKuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2023 06:50:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E9B5
        for <linux-iio@vger.kernel.org>; Mon, 10 Jul 2023 03:50:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso5871243a12.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Jul 2023 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688986211; x=1691578211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDPwSrLOF5LW/yWzR+1bNhfVCa/eBQIFQZu8V0O682I=;
        b=TyAvI2PNtLrs54gZG4nMEK1UZZltbPHz5D+5FhhUo6qgGVhlrkxFaN4fdXRq1x6MKT
         C1w40GLzfH8YLl9JKp/MO7vyzvEq0w12Mu+Lu5K97b9a9PX5v9XjnKyu/U/E+PCKsCOP
         P5lFtGv5LHOC4mihjjWLtYCQEmcQAnxxuVER4K84JY6Jg6Iphg25hk+hxbHP4yUlkNM+
         Reei5I6ruNAuG06KuemLhhcSs5waBZ+I/RgOJif3MDDZuoTPTRY+2xoF1N4986ISw21r
         exdi/qF7oyG3WOr2vCDNE6xnvVuVgjCfIsjEtoJqX5NaBuptglxi5vAMYkYKpc/Q9/Wj
         6W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986211; x=1691578211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDPwSrLOF5LW/yWzR+1bNhfVCa/eBQIFQZu8V0O682I=;
        b=ihzioXKCXbME3UxpOHv2Yker1ixEhT3YF2ZwbKet+FkFHr0GkUu5i/Xkux7fFK2TBH
         ZR2pioo4WTi6qLtchqWFvGXB5ziacbT1Cqxki0s0kNtdCLDjOivVuXKry3WL4W+bNqQY
         12QWrbVPYc59NoNpSumIMZ1dJNq1fC9wTGvh/mh+3OZH/Z+3qVj2beQgBdqIMxfloMHq
         jjzogClOugw/clxLnT/+rm1S2Yp2DYWvitVptdZ2N0VqqZo+dMOxfulsbE1cCXcey2/0
         M/ebbMVXJ0cdow8Gzj4giK1KdjfB/5AzI+3xCLDf3yFsahrJ7PGvOyaLV4JAsPcya0WE
         ZESg==
X-Gm-Message-State: ABy/qLYWpR/PRcfrhONE6+DfzYcJ+8L2GfspFkVBR8NgNkYUnKw+ghfl
        s98eAUZc3w6U3kkpC/39xCpSL79hZ9TByvzAGZJTEPWA8yQ=
X-Google-Smtp-Source: APBJJlHCBN8QZi/yV34iMEIfcDIz0csphMS1hIPBfT1bf2K1y/luLIwcv9D8l7ij9pyXWaoA9y15AEjitTS6sdn56ic=
X-Received: by 2002:a17:906:5308:b0:994:9ed:300b with SMTP id
 h8-20020a170906530800b0099409ed300bmr2080704ejo.16.1688986210782; Mon, 10 Jul
 2023 03:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com> <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com>
In-Reply-To: <11c30a02df784ca78be271fdf9190dad@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jul 2023 13:49:34 +0300
Message-ID: <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Return to the public space of the discussion.

On Mon, Jul 10, 2023 at 11:17=E2=80=AFAM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, July 10, 2023 3:37 PM
> > On Mon, Jul 10, 2023 at 7:27=E2=80=AFAM Kim Seer Paller <kimseer.paller=
@analog.com>
> > wrote:

...

> > > V8 -> V9: Changed SPI buffer data types to __le16,
> >
> > Why?
>
> Based on the previous comments, I have taken the __le16 data type
> into account. The device seems to function the same as the __be data type=
.
> I have not yet sure but technically speaking, do I have to retain the dat=
a
> types as __be16 based on the overall operation?

If the type is __be, the *be*() APIs should be used, otherwise __le and *le=
*().

...

> > Obviously it's incorrect now even more than before.
> > The types are defined as __le, while ops are against __be.
>
> Would it be right to implement this by reverting the types back to __be?
> What other considerations could there be?

First of all, you need to document what you are doing with these bit
twiddlers. Based on the clear understanding by everyone we can suggest
what data type(s) suits the best.

Hence instead of v10, reply with a draft of the comment in the code (I
have asked before) that explains these bit twiddlers.

--=20
With Best Regards,
Andy Shevchenko
