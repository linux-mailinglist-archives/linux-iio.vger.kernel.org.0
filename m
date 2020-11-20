Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1C2BB254
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 19:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgKTSVH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgKTSVH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 13:21:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57872C0613CF
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 10:21:07 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d17so5271130plr.5
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=z57Wr8DH9BlC/Qe77qam1fPDKnckrZ20gmU4aNfz0xw=;
        b=iM8ncfLX0KgbORCi3DAs6OCEBfV1IkEbs3JYjXFbbSK67PH18FGG/fgkur+7PonVId
         irV6MfiK7gnrjX18hw8PLLxYYYQoXG8xGvdaATA7WodBlpJ+5UzhggjnuusKi2MxdL1P
         faJLAbvboPKw6hKPOR7papt0PmWMAtRwnuyX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=z57Wr8DH9BlC/Qe77qam1fPDKnckrZ20gmU4aNfz0xw=;
        b=g9LIiv/BMsHaqXkN4ujSSD5ueCA8ukY8sjajxc8hSJ3AszWH0XZQaOj9cLXvyIwbVU
         rYQ6q/PN9BlSTO2kb2kOgzGOcczPpr4wp5RnH86qSoeFI18+MGlyhI+EyJZyBZKKULwk
         C5NSBBc599iGv5kSXfb7+Pz4LBE2Y09iU5Im2MA/yVkiIRFT/ROhx0bJNvq1iubaHxd6
         njB1Y9jxvceUn+/prmmZEjGf4oEDpqR27jNCzBHmYaRvBfeRQzOkk1dZwIp08Kc0qUWe
         dQ0SNcfqL8Vug/iLGl1xVkvT+vJiyLjqUvWlFKpftrPh59qYYoz7evZtiWO9DWtS4eCF
         o7yA==
X-Gm-Message-State: AOAM533hl6Pw2stREMr2FgSByQ+eF7cnNfPPQsGMtrksyVLhsQQ1+abY
        DmL73mEVUGHXVQ5svis7g7zUDw==
X-Google-Smtp-Source: ABdhPJzNTshQS5bLT73HPE73invTSxue9XswE5YAY4s2fpE0SJ6tzet022K9Lc9J2/KfxvjCyhXgHw==
X-Received: by 2002:a17:902:6943:b029:d6:bd35:c84b with SMTP id k3-20020a1709026943b02900d6bd35c84bmr14696252plt.53.1605896466813;
        Fri, 20 Nov 2020 10:21:06 -0800 (PST)
Received: from chromium.org ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id h16sm4015852pgd.62.2020.11.20.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:21:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
References: <20201120073842.3232458-1-swboyd@chromium.org> <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:21:04 -0800
Message-ID: <160589646471.2717324.9945709609037099045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Doug Anderson (2020-11-20 10:16:28)
>=20
> Checking the math for the documented possible values of pos.  What we wan=
t:
>=20
> 0 =3D> 0
> 16 =3D> 1
> 64 =3D> 2
> 128 =3D> 3
> 256 =3D> 4
> 512 =3D> 5
> 1024 =3D> 6
> 4294967295 =3D> 7
>=20
> So looks OK.  Do we care about anything other than the documented
> numbers?  If my understanding of ilog2 is correct, then you'll get the
> wrong answer for 17.  I think you could fix it with:
>=20
> pos =3D min(max(ilog2(pos), 3), 11) - (pos >=3D 32 ? 4 : 3);
>=20

I don't think we really care about the rounding but to be consistent
with the first two it is better to do that. I'll send a fix.
