Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D94AC223
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359075AbiBGO5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386976AbiBGOcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:32:03 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A221C0401C1
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:32:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 324FD20004;
        Mon,  7 Feb 2022 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/vlI8Ck/EbdFMfroKcsbkSEtVV0+3aQIntQIptdPS8=;
        b=fIVgWGgZhRWHxNbh0Zzf8hk0e6GxRrjJuFRp3J8SSXoAV3oEbl6cRaVwoUwFDf3mp2Hr2S
        RMi2gJ3Q+5bc9W4sjrp7VjKIeisPeR3SW9GBnZe4Mqufeqm3EQW5DV9UGkN3KToBQ6NwHo
        XP5Sy+kutQLHtxEl58o6UFLoShFsfS/jsmhUg/UEL9mYc/teWW74W8DXypEXHF+q7ZAnGq
        y6ATi74OviUf1/kv2R9IFmTH9m8TaCqrBJASoZB5fwaIXEcZkEbdnMU6d/Xc+99Vaf3wRe
        qPWPNDuMwYVpdH869LdtyihDCrBoDG/215yxlkXLPlJsyFdpylysE//yX8N0FQ==
Date:   Mon, 7 Feb 2022 15:31:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 06/12] iio: st_sensors: Stop abusing mlock to ensure
 internal coherency
Message-ID: <20220207153156.38b36fe8@xps13>
In-Reply-To: <20220206154533.3153e610@jic23-huawei>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-7-miquel.raynal@bootlin.com>
        <20220206154533.3153e610@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 6 Feb 2022 15:45:33 +0000:

> On Wed,  2 Feb 2022 15:02:02 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > An odr_lock has been introduced to protect local accesses to the odr
> > internal cache and ensure the cached value always reflected the actual
> > value. Using the mlock() for this purpose is no longer needed, so let's
> > drop these extra mutex_lock/unlock() calls.
> >=20
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Obviously a different issue but all the write_raw() functions should
> use the pattern used in st_pressure_core.c and do early
> returns seeing as there doesn't seem to be any cleanup to do.

I honestly hesitated when dropping the mlocks there. I've done it in
v3, so that we don't hurt our eyes on this anymore :)

>=20
> We can tidy that up in a follow up patch as I'm sure there are other
> areas in these drivers where direct returns would be nicer than
> what is there currently!

Thanks,
Miqu=C3=A8l
