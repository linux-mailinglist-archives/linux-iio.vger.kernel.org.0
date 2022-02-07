Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D74AC21F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbiBGO5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382670AbiBGOgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:36:01 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56BC0401C1
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:36:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4F32C0007;
        Mon,  7 Feb 2022 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdJ8v/RiIFQ8MW/ujahemwb+FPf/ViPCnmM/gE9hyHI=;
        b=GvLzWSVgPwnsHvYA78ikt34+q+YzwX+UvZdwYsAwk6PrrEwACgMytc4bdzsGp4aOjMksIl
        Az5m/B3Een33O0YiYfhQ6PvVf6yaypLyPemiK4V0YIxsoqO0zd/2B1qcUj1B2l8ydRDkBw
        kpVmLmxURAIX8z8uCvIZn9RsSyev5uTvKNRYoVrWBzT/W67OsS2Xaql3lmVXl9vnJ+rfD+
        JLmtBDIHOrxiGRs1nHBY5VDhcNYJc4dInNkRrcnOD0BEMNYLmCpRg8N1GCKifXfr+hKirb
        QzFAXuVBzIrRBKIctL6xifEEucwSyktnPWCytpXs//Ej/kFWT70sMwAXBc5kKQ==
Date:   Mon, 7 Feb 2022 15:35:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 12/12] iio: core: Clarify the modes
Message-ID: <20220207153556.453ccb9c@xps13>
In-Reply-To: <20220206160937.7d77b94a@jic23-huawei>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-13-miquel.raynal@bootlin.com>
        <20220206160937.7d77b94a@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 6 Feb 2022 16:09:37 +0000:

> On Wed,  2 Feb 2022 15:02:08 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > As part of a previous discussion with Jonathan Cameron [1], it appeared
> > necessary to clarify the meaning of each mode so that new developers
> > could understand better what they should use or not use and when.
> >=20
> > The idea of renaming these modes as been let aside because naming is a
> > big deal and requires a lot of thinking. So for now let's focus on
> > correctly explaining what each mode implies.
> >=20
> > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-hua=
wei/
> >=20
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> Very nice.  One random comment on another area where our docs could do wi=
th
> improvements and one trivial suggested clarification for this patch.
>=20
> Thanks for your hard work tidying this up!
>=20
> I've looked over all the other patches in the series and where I haven't
> commented they look good to me.

Inline comments addressed, thanks for all the feedback!

Thanks,
Miqu=C3=A8l
