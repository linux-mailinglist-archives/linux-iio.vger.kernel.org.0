Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6616314929
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 07:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBIG46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 01:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBIG4x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 01:56:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B34C061788
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 22:56:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so1039191pjb.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=1VQlx/2/YkuOYTWGDUV7OgUbtuznsUJ7Xrjo6N4F/gc=;
        b=k+KHbQzReCQtbgzkjuX+ZSe6xLBxlh1M9pOc/UykVT+9aCT3ZQMNKNKSAyG8TA7ygO
         srRUyqCAA3+6ViRczqo1WCHKpP0h5DOhpLuQ3KqzyEEfSy6DXO4IMcAlkjEKyxpzmZpG
         wj0QiSXlj5ib5o8dHrWvlvddqYQg1B3Ooozd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=1VQlx/2/YkuOYTWGDUV7OgUbtuznsUJ7Xrjo6N4F/gc=;
        b=gsdHU+RU9QD+n8/Eq9C7IqjNK8k8kQH7sxtH7SYw1fWhpu9ONirdwPWFN8FOrjFQs2
         VS5RY5fAkQ/1JylKl/6O33rU1iYwSKKEYQZ0HCfgAq22dQBpNEscy96AFNNuRQnLlef1
         5mGPUuKfX2tIQWHhqJsbwuLIHSB/yYzWoIayf87ULLWcFjUd2qVmT1pfiVA1rnxKX89G
         d3DtOiP5NwhAX7WiAX8k+aXribGNOIfYNsR0gtPjXbuzkYHEuoUlAe+Fe8UVTU8C5Tpo
         m6lb3DPnCpiqWjMCXowvFYzjMQ4diESgtISiOMeviW8Ihu4EXQpiMbPZTe1FE05CfVXO
         RcgA==
X-Gm-Message-State: AOAM532DWEAp/faYNx/TDrx4fgjx3aAbMVQ0PKwO+r75Pq9pOdXevi27
        WtZSK+PC4TK7phNNYONz9YY8uA==
X-Google-Smtp-Source: ABdhPJxZshnqvvt9y7aiV4MD3X1K+XyzlaBrcOJ/DR0QrTOUVrKHwncJ8LZtR7Ot1yysnQqEtEwKPg==
X-Received: by 2002:a17:90a:3e01:: with SMTP id j1mr2663906pjc.138.1612853771728;
        Mon, 08 Feb 2021 22:56:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:751a:ba0b:8918:c305])
        by smtp.gmail.com with ESMTPSA id u14sm11467257pfc.39.2021.02.08.22.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:56:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2usY4GZhGkjmibMfVUTzK3c_Lz5HqNFo_fVRa_gqkmk8OQ@mail.gmail.com>
References: <20210202064541.2335915-1-gwendal@chromium.org> <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com> <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com> <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com> <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com> <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com> <161283922598.76967.9707750025474688009@swboyd.mtv.corp.google.com> <CAPUE2usY4GZhGkjmibMfVUTzK3c_Lz5HqNFo_fVRa_gqkmk8OQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 08 Feb 2021 22:56:09 -0800
Message-ID: <161285376928.76967.17468133318196687432@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-08 20:07:19)
> On Mon, Feb 8, 2021 at 6:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Stephen Boyd (2021-02-08 18:38:20)
> > >
> > > Isn't that a bug in the ACPI property reading code? 3 doesn't overflo=
w 4
> > > so I'm lost why it would return an error code to indicate it can't fit
> > > the whole property into an array that is one size larger.
> >
> > Or it's a bug in the driver because it's assuming that it can read the
> > DT property out even when it is only length 1 when the property read
> > should be variable length. Can you split this into two and fix the
> > underlying problem with the read of the array not matching the length of
> > the property? I think it needs to be
> > of_property_read_variable_u32_array() with 1 and 4 for min and max.
> Splitting the patch in 2 does not make sense given
> of_property_read_variable_u32_array has no equivalent in the
> device_property_read_ realm.
> That function introduced in the first patch would be removed in the
> second patch.
> I will update the commit message to indicate this patch takes care of
> the "semtech,combined-sensors" variable array for both DT and ACPI.
>=20

I suggest we apply this patch and send it back to stable trees. I didn't
notice because I was setting combined-sensors to 3, and that is the
default value and it was getting removed from the default register
values all the time, even though the read of the DT property was
failing. With this change we'll always read the array and if the length
is less than zero or more than the size of the array we'll break early
and get out of there. Otherwise we'll continue on and build a bitmap out
of the values in the array to compare and set the reg_def->def bits to.
Importantly we don't mask out the settings from the default register
values until we successfully read the property.

After this change you can introduce the device_property_read_*() APIs to
add the new feature. But this is a fix that needs to be backported.

----8<-----
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6a04959df35e..6ba063e51af5 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1236,15 +1236,17 @@ sx9310_get_default_reg(struct sx9310_data *data, in=
t i,
 			reg_def->def |=3D SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
 		}
=20
+		ret =3D of_property_read_variable_u32_array(np, "semtech,combined-sensor=
s",
+					   combined, 0, ARRAY_SIZE(combined));
+		if (ret < 0)
+			break;
+
 		reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
-		of_property_read_u32_array(np, "semtech,combined-sensors",
-					   combined, ARRAY_SIZE(combined));
 		for (i =3D 0; i < ARRAY_SIZE(combined); i++) {
-			if (combined[i] <=3D SX9310_NUM_CHANNELS)
+			if (combined[i] < SX9310_NUM_CHANNELS)
 				comb_mask |=3D BIT(combined[i]);
 		}
=20
-		comb_mask &=3D 0xf;
 		if (comb_mask =3D=3D (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
 			reg_def->def |=3D SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
 		else if (comb_mask =3D=3D (BIT(1) | BIT(2)))
