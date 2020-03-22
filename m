Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E925B18ED44
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCVX0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 19:26:14 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34274 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVX0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 19:26:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so5059761pje.1;
        Sun, 22 Mar 2020 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDKQMZnLV2Qxu2G2wWsWQEZI3Xmwo2zYfXZksiF4wOY=;
        b=Mv5Fi2wtUcS1EUcl7QT0VXTLjfoS4onO9OZbnEUT04S9/8ccgjdFiycWWn52Ydw/iF
         yItaI8TiAWHFHOhM+9ga/M2EiSZTn4DuR6pMfmmJ5QjUfsvG3G8oNKigZYCjbkju4Qs1
         BfimpVE9iFttTgJaeziTWulobv1XKLxmhnl7+HF0qhQ4c9C8vqyLfFqrlsEwg58bL7xu
         cUbThefH40SQSSrIkjr3N/s6TotsVqXy/QN4Vjo95a0M6k3Tor1QLvClkR5YKP+LLvBK
         y3pzJwob7QPVinRXQMY/HJVv1vbBSBeLf8Pbj8nmzapGsmUsrk6EQnk9HRZezxS4cpNy
         rsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDKQMZnLV2Qxu2G2wWsWQEZI3Xmwo2zYfXZksiF4wOY=;
        b=GI6XFfwZbDVyiL6FxIsywY24KohmaYZMiNCOhofVF71UvYZDb0LPuhQAibnYIMz5Gf
         XD++i7Dwu1o9+GeqosbC0MXJNjuAHpReNOo86yzUUOBtxRBY/gQdTByGK5WQWzgPs/Z6
         sRpf3TRjrT+hMx8oO5n3Fj1JHDseo733uJBojRvvCI/2cbsqH+NrMZP1CB8rc9+0SAO2
         KHnfMOf2NObjePZbpXaiLBWQ30euJB2FxId1eMc4BkI7E5haGuBqJVPhXSDmnC3WPR1e
         vymEtzxW6jKSQcV4DvKtBybXNbUKPB/eisi2JY/p8Vl9YD0zOVtVttb3i2yZLDKpCyUZ
         xEtg==
X-Gm-Message-State: ANhLgQ1T5jpC9S6C0uHni6JiHwlxsjN8C6e5n/jZetT8iyuH2rI0549W
        iAqJLFQ9legIY5Q/UxuRkA0r9C2hmBC+jRB2LBg=
X-Google-Smtp-Source: ADFU+vvW2kjUDse5l5NFdqxGMDTjhGi14s5N4SJUT/TVrlYDd6CZNBX+yJSMVIfRDYpLBRnaYmLavSvnN5U2StVAm5w=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr22305527pjn.8.1584919572031;
 Sun, 22 Mar 2020 16:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200322224626.13160-1-sravanhome@gmail.com> <20200322224626.13160-5-sravanhome@gmail.com>
In-Reply-To: <20200322224626.13160-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 01:26:00 +0200
Message-ID: <CAHp75Vf0iAV1g5GV8XoewNEMnGee=_Wkgz=8Y_ym8UPdsb6eFQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] power: supply: Add support for mps mp2629 battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.

...

> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +#include <linux/of_device.h>

Do you need this one?

> +#include <linux/interrupt.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/types.h>
> +#include <linux/power_supply.h>
> +#include <linux/workqueue.h>
> +#include <linux/regmap.h>

Perhaps put them in order?

> +#include <linux/mfd/core.h>

How this is being used?

> +#include <linux/mfd/mp2629.h>

...

> +#define MP2629_MASK_INPUT_TYPE         0xe0
> +#define MP2629_MASK_CHARGE_TYPE                0x18
> +#define MP2629_MASK_CHARGE_CTRL                0x30
> +#define MP2629_MASK_WDOG_CTRL          0x30
> +#define MP2629_MASK_IMPEDANCE          0xf0

GENMASK()?

...

> +       struct regmap_field *regmap_fields[TERM_CURRENT + 1];

Hmm... Why not to have a definition to cover + 1?

...

> +static int mp2629_get_prop(struct mp2629_charger *charger,
> +                          enum mp2629_field fld,
> +                          union power_supply_propval *val)
> +{
> +       int ret;
> +       unsigned int rval;
> +

> +       ret = regmap_field_read(charger->regmap_fields[fld], &rval);
> +       if (!ret)
> +               val->intval = (rval * props[fld].step) + props[fld].min;
> +
> +       return ret;

Why not to use standard pattern, i.e.

  if (ret)
    return ret;
  ...
  return 0;

?

> +}

...

> +static int mp2629_charger_battery_set_prop(struct power_supply *psy,
> +                                       enum power_supply_property psp,
> +                                       const union power_supply_propval *val)
> +{
> +       struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);

> +       int ret;

You may replace it with in-place return statements.

> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +               ret = mp2629_set_prop(charger, TERM_CURRENT, val);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +               ret = mp2629_set_prop(charger, PRECHARGE, val);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +               ret = mp2629_set_prop(charger, CHARGE_VLIM, val);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +               ret = mp2629_set_prop(charger, CHARGE_ILIM, val);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }

> +
> +       return ret;

...and drop this completely.

> +}

...

> +       case POWER_SUPPLY_PROP_ONLINE:
> +               ret = regmap_read(charger->regmap, MP2629_REG_STATUS, &rval);
> +               if (!ret)
> +                       val->intval = !!(rval & MP2629_MASK_INPUT_TYPE);
> +               break;

Traditional pattern?

...

> +static int mp2629_charger_usb_set_prop(struct power_supply *psy,
> +                               enum power_supply_property psp,
> +                               const union power_supply_propval *val)
> +{
> +       struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);

> +       int ret;

No need to have it.

> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +               ret = mp2629_set_prop(charger, INPUT_VLIM, val);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret = mp2629_set_prop(charger, INPUT_ILIM, val);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}

...

> +       return (psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT ||
> +               psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT ||
> +               psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
> +               psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE);

Redundant parentheses.
Ditto for similar cases in the driver.

...

> +static ssize_t batt_impedance_compensation_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
> +       unsigned int rval;
> +       int ret;
> +
> +       ret = regmap_read(charger->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);

> +       if (ret < 0)

' < 0' is not needed.
Ditto for other cases.

> +               return ret;
> +
> +       rval = (rval >> 4) * 10;
> +

> +       return scnprintf(buf, PAGE_SIZE, "%d mohm\n", rval);

Simple sprintf().

> +}

...

> +static ssize_t batt_impedance_compensation_store(struct device *dev,
> +                                           struct device_attribute *attr,
> +                                           const char *buf,
> +                                           size_t count)
> +{
> +       struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
> +       long val;
> +       int ret;
> +
> +       ret = kstrtol(buf, 10, &val);

> +       if (ret < 0)

No need to check for negative only.

> +               return ret;
> +
> +       if (val < 0 && val > 140)
> +               return -ERANGE;

And what the point then to use l instead of ul or even uint variant of
the conversion above?

> +       /* multiples of 10 mohm so round off */
> +       val = val / 10;
> +       ret = regmap_update_bits(charger->regmap, MP2629_REG_IMPEDANCE_COMP,
> +                                       MP2629_MASK_IMPEDANCE, val << 4);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}

...

> +static int mp2629_charger_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;

> +       void **pdata = pdev->dev.platform_data;

Why void?
Why **?
Why not to use dev_get_platdata()?
Why do we need platform data at all?

> +       struct mp2629_charger *charger;
> +       struct power_supply_config psy_cfg = {0};
> +       int ret, i;

> +       charger->regmap = *pdata;

> +       regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
> +                               GENMASK(6, 5), (BIT(6) | BIT(5)));

Too many parentheses.

> +}

--
With Best Regards,
Andy Shevchenko
