Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFF38D6FA
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEVSgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhEVSgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:36:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A91C061574
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:34:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t9so4163470ply.6
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UT3idbb+/CKlgAZo8J+QyttKJ62VQ/voVfgpCB2NdyU=;
        b=J5bAPZF4Ka5Bm5ReT+pAgr6e+ORxz1zfdvsbG4tdIL1zt33akgEKdI8nC1Www790nI
         2dsgZPO/zQkJ4UPYn23eIMsVkuhlBjBrBrH99kH3DqMPTC2mDU8o3aWwVaOSxj2h5VKr
         A43K84c/T1JLKo4ooHyFHOAO2q9DSbnLWAIaCFJ1NXr6XdXNK1U5BXqF7kcn/mKXC+8I
         cpnRCvOaKgon0gyTQ6JYq2qgY0TgPVrp0U03J+wEnXMvGa5u6VRnEaxTsGMzVHmaIREL
         TdWHrJ6J1A+alIxqGw3W8ug7lXDGPkn9DyCWsgnGdU38OLYoSScBLIYX5BcSndjwBOlf
         8maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UT3idbb+/CKlgAZo8J+QyttKJ62VQ/voVfgpCB2NdyU=;
        b=gIvPVZ9GX6Hv9Dw3FZY69VLDSqSlPvuufjMl6ZvUzxuz1F+IHrMOM0BG8YtOyBhdBi
         rr/D3yUyqyUaob6nP4UIzjQVBcBBz8ivvgNV4cpHJTHYIf1P6jq90bOAA23FUellIbct
         q5I+KlQM+2KxURP5auAYJEWgvZSL+ybP1OqDfSK1t2iAEQqlJyK1hip8bnmE6lbB09H6
         vOkbLIi2DkMQbXgAC14V3Aw7u6L+z5Z51pXwVxoe9ZdRLnD4PGXSmTw9tZzpQRsyRlET
         FJOQGuk0091V0l0GbKNARBDwoIMSJM1pmuqeqEcTfU6c1S5aEtc4TIqAUEq9ERzQ3zsN
         MiWQ==
X-Gm-Message-State: AOAM532oaWPJBsjbaOdBM9erxD6A9aIRSafYwXgoMXnizaRW7h/0SgNs
        vfheHVnxOc19ANt2wkFAW3VuF4f9y4sfVChg1DQ=
X-Google-Smtp-Source: ABdhPJy1U2YceGLwHCiM/BicK0yVF4RzJdhSMODobo4Pfb6dJSj5p5+9aFEwW5Hq1tWUIakJUVOXnCOC0hQg52gIRXY=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr18139299plc.0.1621708477253; Sat, 22 May
 2021 11:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210521171418.393871-9-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-9-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:34:20 +0300
Message-ID: <CAHp75VeOpT9yJx8FT57NwQQCo0ojs+-sHZn7D3DSA=caH3FZMg@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: accel: bmc150: Set label based on accel-location
 for ACPI DUAL250E fwnodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some Yoga laptops with 1 accelerometer in the display and 1 in the base,
> use an ACPI HID of DUAL250E instead of BOSC0200.
>
> Set the iio-device's label for DUAL250E devices to a value indicating which
> sensor is which, mirroring how we do this for BOSC0200 dual sensor devices.
>
> Note the DUAL250E fwnode unfortunately does not include a mount-matrix.

> +       /* Special case for devices with a "DUAL250E" HID */
> +       if (adev && acpi_dev_hid_uid_match(adev, "DUAL250E", NULL)) {
> +               if (strcmp(dev_name(dev), "i2c-DUAL250E:base") == 0)
> +                       label = "accel-base";
> +               else
> +                       label = "accel-display";
> +
> +               indio_dev->label = label;
> +               return false; /* DUAL250E fwnodes have no mount matrix info */
> +       }
> +
>         if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
>                 return false;


This sounds to me like

_apply_orientation_generic()
...

_apply_orientation_dual250e()


_apply_orientation()

if ()
  return _apply_orientation_generic()

if ()
 return _apply_orientation_dual250e

return false;



--
With Best Regards,
Andy Shevchenko
