Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691D6CEC8D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjC2PPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjC2PPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 11:15:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE326A1
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 08:15:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so16088942wrm.10
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680102912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Z4nfliXDq8WTGr2ssuPTBOeZD0dFDOkrIvQkjgfpXA=;
        b=okE4VPo6ENx0xZO/CcaaIlIfgdLCn0i55NKwXQbOcIWB4rXsjQgbNIEES5hzCzRkNi
         Ukz58yXOF5UGcWZLcaVsVaoxAC0qoJOargeg9H3rWlbxJWqv38pc2BJnu6j7+X8b+wI+
         7H6Qt4hWCj4J675GoniFo243EkKJF8Lfgx13llrt0X4FQeLFCN3J/KRInut0ZC9SdWO5
         HwFIf2WhiZSgYwebDPLvqmMwuuGJwKeIGb91hllu5TK3rG3+KgHrNhr+IKTiIUDyrshD
         NXl5Nmr+XQcxGHTrKiHnZOGq1NAvDIXg23WafLKRaJNIf3GhW8H6sMubyrhxZGVkOIrG
         oX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Z4nfliXDq8WTGr2ssuPTBOeZD0dFDOkrIvQkjgfpXA=;
        b=QzOCXXJzAhSTH6rihEpr71n+rPmuP1qv8jdhTDr/igp+qanTez8Eh0KDUJOmxiO9nJ
         Yqmu4uGRE4l8zD/udw/A0cpJwfPVs5zuDeFkQWDMjwbMyPf9w8T71qugV7OtYg4hs/cm
         hAOV+ptqdcIrEzt9bziU+7VeOzXGvAQGbzuANE8R/wroKlv76jg4I/a70mN+KubngjYE
         I8wTSq+AblSOfIVZYp2F6mOPwtG9Ici2O6BMaJfdrCAWWK/RUsIpbyfdxIiUrSIl/kuF
         cA+C6kTYZiTQcKypjD+V3naOMNDlvQjxyuMmPKqmpL8w9ua4M+U5yL/nUbOgS0AwW7G5
         0yxg==
X-Gm-Message-State: AAQBX9eWbfLtiqHtX9CiBZrOfVYdtL5QNqECK8GNQipMzNG1IRwcjzlD
        RPoA7q5s4IYPHcEQcfZ502k=
X-Google-Smtp-Source: AKy350aivTjTkMdoEXWZYlXfJAZk0owXEBnRgtw98uUulktn8qpJjDD7Osdet6kmznLDYmaAMzd5Tg==
X-Received: by 2002:adf:f348:0:b0:2d7:9206:488d with SMTP id e8-20020adff348000000b002d79206488dmr15433159wrp.36.1680102912549;
        Wed, 29 Mar 2023 08:15:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id j10-20020adff00a000000b002d1bfe3269esm30473131wro.59.2023.03.29.08.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:15:12 -0700 (PDT)
Message-ID: <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org
Date:   Wed, 29 Mar 2023 17:15:11 +0200
In-Reply-To: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote:
> Allow the use of external clock when mclk clock is defined.
> When defining a mclk clock source in device tree with adi,clock-xtal
> property, the external crystal oscillator is not turned on.
> Without the change, the driver always uses the internal clock even
> when mclk clock is defined.
>=20
> Current implementation seems to contain a typo, since it expected
> st->mclk to be NULL within ad7192_of_clock_select() in order to
> select
> the external clock, but, if null, external clock cannot loaded
> correctly (out of bounds due to invalid mclk) in ad7192_probe().
>=20
> I believe this patch follows the author's intended behavior.
> =C2=A0After applying this patch, the external oscillator is started as
> expected.
>=20

Yes, looks like a valid fix... Just missing a Fixes tag.
> I kindly ask your feedback, I may adjust the patch according to your
> suggestions. I could also follow up with another patch on
> documentation, containing the following (related) issues:
>=20
> - adi,int-clock-output-enable is undocumented
> - adi,clock-xtal is undocumented
> - regulator name avdd and its description is quite misleading, since
> this is unrelated to the AVdd pin (#20) of AD7192; it is used instead
> as reference voltage (REFIN1 on #15/#16 or REFIN2 on #7/#8). See
> int_vref_mv variable within driver implementation.
>=20

Don't think the above text belongs to this commit message. That said,
it would be great if you could follow up with a couple of patches to
document the undocumented properties. As for the regular name, I think
it's not so trivial to change it's name because there could be already
users using the property like this. So, I guess we have two ways:

1) Just add some description in the property to state what's this
regulator really is about.
2) This one is more complex but might be the right one... Deprecrate
the current property (you can mark a property as deprecated in the
bindings) and add the new one with a proper name. Then, you need to
change the driver accordingly keeping in mind that it must still work
with the old, deprecrated property.

Was lazy to ckeck but I'm assuming the bindings are already in yaml...

> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> --- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42.6=
46239506

Anyways, for this patch and with a proper fixes tag (and with the
unrelated text removed from the commit message):

Reviewed-by: nuno.sa@analog.com


