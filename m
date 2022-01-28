Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D523549FC4F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346908AbiA1PAe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 10:00:34 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47211 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348674AbiA1PAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 10:00:08 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 02F442001E;
        Fri, 28 Jan 2022 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643382005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGIzn8Fas948vf0yRWBH4YBQYxNfQadBtMDNzSIqSXU=;
        b=Ez37e3b56Yg33saOQLV0PXvA9WeOHqYbevmSAMv9tkT1NNaf+8qa7wtZvZa1FYVpvuC8Go
        9Y9QiUp0DTQiVcTPLy8tdLGBVxFNWxXk+l/ar6MgbbL3zIRLq6+CPH8rbnMTo8reibVI4Z
        oNMCOlm0BwjTUlvy0Spvvbj6Ul1gIlQ3Ly7Mq4b7ms0y0sKvxqQbA6eFQarRdMAaYPY3Sp
        G5p6n84z6luCkcXxnXy47QztqFfLtADiASHoI74nz1epg//4OQowJhyMiM1k/Wj2cUxV7t
        4RZYb9KEyOACyDj4zFEikznBg8UIlh6J+IJT750V8psdb/aOjrKHRUShBauZMA==
Date:   Fri, 28 Jan 2022 16:00:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH 03/10] iio: magnetometer: rm3100: Stop abusing the
 ->currentmode
Message-ID: <20220128160002.3e927de8@xps13>
In-Reply-To: <20220115155832.1f431e65@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-4-miquel.raynal@bootlin.com>
        <20220115155832.1f431e65@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 15:58:32 +0000:

> On Wed, 15 Dec 2021 16:13:37 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > This is an internal variable for the core, here it is set to a "default"
> > value by the driver in order to later be able to perform checks against
> > it. None of this is needed because this check actually cares about the
> > buffers being enabled or not. So it is an unproper side-channel access
> > to the information "are the buffers enabled?", returned officially by
> > the iio_buffer_enabled() helper. Use this helper instead.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> Hi Miquel,
>=20
> Make sure to +cc driver authors on v2.
>=20
> Whilst I think this is safe we should definitely give them visibility.
>=20
> Obviously some IIO drivers probably have authors who have long moved on
> but this one is only 2018 vintage so Song Qiang might still have
> access to hardware or be willing to do a review!

Right, I've added Song Qiang into a Cc: tag for this patch for the next
iteration.

Thanks,
Miqu=C3=A8l
