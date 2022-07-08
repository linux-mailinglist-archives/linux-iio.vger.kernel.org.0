Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05F456B74C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jul 2022 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiGHKeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGHKeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 06:34:22 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACF7E006
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 03:34:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g1so15348176qkl.9
        for <linux-iio@vger.kernel.org>; Fri, 08 Jul 2022 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=BZlau7tp2acP2iGeovkvdKDRglPh38C6p77PrHYGEvY=;
        b=i8rz3Uw178sMsETcthkjVorWi6qZIa643gAqmT+Brgcd9gN21okO3AyqwQyM/dUk4k
         64JLYAdrpDWVVt/PjW53w//lDloeY8xUft7sUy3ZhEymE1SsbErtj9Ewb6PPtNG+kvdO
         F12c7gBFfmJzq/8yNzLA156NUaqSRRE3Xou7kMO06gHeQ5aGf3g5d2ek7DlzsPpop8sp
         +fThBjg1BifDXfIOxQDnfsMniPcmXVn8zdxEnuNjAyQvAaUQv+whWvZ8ShmqqTb9qBWt
         P/82bCZLUfeVIvTq2SrlUB9mz3hLJWSRmO3/yDwKGsGG/1b0eq4CxFa0yqQ4YvzyJ1fb
         6hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=BZlau7tp2acP2iGeovkvdKDRglPh38C6p77PrHYGEvY=;
        b=e1aN+UZTTj/4/qQKTrxhwVT7vgeCEwaedqSlSEmGPf3StkX/tJIrt32aI7rtRrBrIy
         u+FaLIcQR0Q6BUmicgilZjEaz9hK+S8eeZ+4TDqp+iNZImc84x61FEssINhun7MhHA/7
         5tIQ6d2yMniRc/mJ3JMPJzSBbnR99KpDAK7lQptKMJSsd14D8sAM/Rw3pv4cMbYzX/lh
         EdHhlfvtpMe7POoWjNU7vauksMtTHzmCUFQP9ynrFAseSegJnG+JCXmrY0s6BOWXyzsj
         KFS6pB7Mjg9tmG8Ev/gS0gBsawS3C4JcAq09QcL+aPN6vnZ2i3/Ct16KTBUu4kk58uNg
         fI6A==
X-Gm-Message-State: AJIora97dd6Qwy1xi+eyYk9qwkp6n4K/AYIONAb+6qWpI1XqFIOsbUwV
        T8TYK0ErcN3KZa6RKkEaS/I=
X-Google-Smtp-Source: AGRyM1upOSpvkKgJTzji+uAaxa+lYVHjUluBueXVLD4Za2FmMascV+t5wlCyj6U/2Q2mD4goItm1WQ==
X-Received: by 2002:a05:620a:400f:b0:6af:53bc:7311 with SMTP id h15-20020a05620a400f00b006af53bc7311mr1681958qko.305.1657276459751;
        Fri, 08 Jul 2022 03:34:19 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id i16-20020ac84f50000000b0031ea1ad6c5asm1971447qtw.75.2022.07.08.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:34:19 -0700 (PDT)
Message-ID: <496f7dec852e556c44c065cd6dbbfd9c3032dd47.camel@gmail.com>
Subject: Re: ti-ads7950: selecting the adc input range
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Thorsten Scherer <t.scherer@eckelmann.de>
Date:   Fri, 08 Jul 2022 12:35:19 +0200
In-Reply-To: <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
References: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
         <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-07-08 at 11:28 +0200, Lars-Peter Clausen wrote:
> On 7/8/22 10:02, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > the ADS7950 has a register bit (called TI_ADS7950_CR_RANGE_5V in
> > the
> > driver) that selects the input range. Depending on that bit the
> > input
> > range is either [0 .. V_{REF}] or [0 .. 2 * V_{REF}].
> >=20
> > The driver currently defaults to setting that bit, so the range is
> > the
> > big one.
> >=20
> > On a machine here however I know the input is in the smaller range
> > and
> > I'd like to benefit from the higher resolution of the small range.
> > I
> > wonder how to make this tunable. Should that be done using a
> > firmware
> > property? ("single-input-range" vs. "double-input-range"? Or input-
> > range
> > =3D <1> vs. input-range =3D <2> which better matches the data sheet
> > that
> > calls the two modes "Range 1 (0 to V_{REF})" and "Range 2 (0 to
> > 2xV_{REF})") Or should this be made tunable via sysfs? (E.g. by
> > writing
> > to the scale property? Or a separate property?)
>=20
> Hi,
>=20
> Its a bit of a tricky one. You can find arguments for and against=20
> either. Like "devicetree is for hardware description and not
> application=20
> specific configuration data", or "I know which setting I want to use,
> having the kernel apply it makes it a lot easier".
>=20
> What we've done in the past in the IIO framework is to make the scale
> property writable for such devices. Together with a scale_available=20
> property to list valid options. This is the most flexible option as
> it=20
> allows to change the setting at runtime for applications where it is=20
> required.
>=20

Yes, it's a tricky one and I have the feeling that thoughts about this
are changing frequently :).

Well, this feels identical to what I had in a DAC [1] I recently
upstreamed. IIRC, on the first version of the series or during
discussion on the RFC I also had in mind to make it configurable
through sysfs but Jonathan advised me to go with a fw property.

[1]:https://elixir.bootlin.com/linux/latest/source/drivers/iio/dac/ltc2688.=
c#L786

- Nuno S=C3=A1
