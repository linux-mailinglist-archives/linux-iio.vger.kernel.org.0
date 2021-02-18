Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABB31E785
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 09:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBRIfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBRIcS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 03:32:18 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA0C061756
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 00:31:36 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z18so764858ile.9
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 00:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FnFnVnaRXrT40XcK7ypp9vNkYsCDr6Wn8f1eLQ+uols=;
        b=uM50+NioPVvCdWMRfHvD0wSrIxdhjoTw0SY8GRtrbEeoNZUr3ybB2GbVc5iWmlTJUV
         3D5G1tTFJzAwzRQY6HKCITQX5TcXLRgxMe3WyqpdLys6DjJYyIQt+QvjkTU+D4ICgJET
         PaFc/9k0J4pCTUU7athTlKgVTr0Jv4nudiZow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FnFnVnaRXrT40XcK7ypp9vNkYsCDr6Wn8f1eLQ+uols=;
        b=k5xeQt65nm37b0bKTVvJ8lJlNgR/5YGR5scElH03i/HQ0/giFQXtT02jHfN0OLgLZ4
         b1gACXlIn9OrsixRAZTiLJLyU9LFZoxqI696dpONT1Fq5caX5ZiyQ6UiBbzWKgnn7llG
         Y53NlnwZdhxgtRF2HuvEQocoG9MD1aRgaJk2qDquoGj/pUkZJ0lLon1NvfRAG/y4vDsp
         aEBPdCPQPovOzx64/Ibi8uhcm7riFa3cDG83xp9MIr9HvI2iEGiGLsMajIZjKGl7VcXU
         qlB8QadW079iacLuRl4KkA6F/L4gFf77IiaeQ5oSsWY3oYuM49Den5BTEuk11xe9ph9l
         ZCfQ==
X-Gm-Message-State: AOAM533vkUvbEQlK1QEIDmWb1/J0EOcIK7z/kFqFplT9SWlr1BcUMlYK
        mJwsO5g1pzGp5+HUu6m0yfadsGNr3HCnjb39iQQPMOEI/puAa8o5
X-Google-Smtp-Source: ABdhPJxJclJaYxiYQQxxB3evx7zwOfO0qXC2GpmC6xa1Z8YdOtteTvzh7HXwnbsuYS/OGGXGvU2WcNm6O3l3Py/0Trs=
X-Received: by 2002:a05:6e02:eb4:: with SMTP id u20mr2827217ilj.142.1613637096277;
 Thu, 18 Feb 2021 00:31:36 -0800 (PST)
MIME-Version: 1.0
References: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
In-Reply-To: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 18 Feb 2021 00:31:24 -0800
Message-ID: <CAJCx=g=kJz21ZwH5yYoRjZUbDhP0ZEoGe9+mBB2uB+=h9sAQRw@mail.gmail.com>
Subject: Re: Control Register device tree binding request for Opt3001
To:     =?UTF-8?Q?Ekin_B=C3=B6ke?= <ekin_boke@arcelik.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "cengiz@kernel.wtf" <cengiz@kernel.wtf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 17, 2021 at 9:20 PM Ekin B=C3=B6ke <ekin_boke@arcelik.com> wrot=
e:
>
> Hi,
>
> We are using Opt3001 for a day light control system and according to the =
data sheet it has 2 conversion time modes
> that are 100 ms(CT=3D0) and 800 ms(CT=3D1) . Configuration register field=
 CT controls the conversion time and we want to set the CT parameter at the=
 initialization to 0 at all times. We could do it by using the in_illuminan=
ce_integration_time sysfs node at the runtime.
>
> Should we add a parameter to the device tree bindings or is there another=
 way to set the CT parameter at the initialization?
>

Yes, it would make sense to have that in the device tree if it isn't
going to be switched on runtime. However if it is supposed to be
configured at runtime you could have a) devicetree + sysfs
configuration b) or just sysfs if timing isn't important.

Although devicetree configuration if *optional* probably wouldn't
hurt. I'm sure Jonathan will have a comment either way :)

>
> Best Regards
>
> Ekin
>
>
>

Just a slight pedantic note that some people won't respond to some
emails on kernel mailing lists due to the following message (corporate
legal departments and such).

- Matt

> Bu e-posta mesaji kisiye ozel olup, gizli bilgiler iceriyor olabilir. Ege=
r bu e-posta mesaji size yanlislikla ulasmissa, icerigini hic bir sekilde k=
ullanmayiniz ve ekli dosyalari acmayiniz. Bu durumda lutfen e-posta mesajin=
i kullaniciya hemen geri gonderiniz ve tum kopyalarini mesaj kutunuzdan sil=
iniz. Bu e-posta mesaji, hic bir sekilde, herhangi bir amac icin cogaltilam=
az, yayinlanamaz ve para karsiligi satilamaz. Bu e-posta mesaji viruslere k=
arsi anti-virus sistemleri tarafindan taranmistir. Ancak yollayici, bu e-po=
sta mesajinin - virus koruma sistemleri ile kontrol ediliyor olsa bile - vi=
rus icermedigini garanti etmez ve meydana gelebilecek zararlardan dogacak h=
icbir sorumlulugu kabul etmez. This message is intended solely for the use =
of the individual or entity to whom it is addressed , and may contain confi=
dential information. If you are not the intended recipient of this message =
or you receive this mail in error, you should refrain from making any use o=
f the contents and from opening any attachment. In that case, please notify=
 the sender immediately and return the message to the sender, then, delete =
and destroy all copies. This e-mail message, can not be copied, published o=
r sold for any reason. This e-mail message has been swept by anti-virus sys=
tems for the presence of computer viruses. In doing so, however, sender can=
not warrant that virus or other forms of data corruption may not be present=
 and do not take any responsibility in any occurrence.
