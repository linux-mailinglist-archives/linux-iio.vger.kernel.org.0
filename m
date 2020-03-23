Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4810A18F494
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgCWM3q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 08:29:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33633 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgCWM3p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 08:29:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so16858724wrd.0;
        Mon, 23 Mar 2020 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jyZpX9epTT5FK26pIiLWMLzpnn3Jdo8Hr6anKqJcGcw=;
        b=gIuqhKNEOVf/0ds6bvlJfibBZ/uq8oeegLDsjM8ysEkzss60Sj7NW02h+CzV7R7YtO
         NorILoY3Lsr2cWfYI6u7F22pRI2f2hJQXrNY+gDmnJLA9wzIJsaApD7qtmFdWquFjyNF
         jh8DUlHRTuUmdw5LcF5TWfTUizHi2vUecaflIqcW3xsF4s/c4sexXjOVBZ7fniI2S+O8
         oukUIZAE4f/TgvmXS+H40SZkpjcACUS1Qf/4G9T1DgHM8EONOOXqoxso6PikIdATjLFV
         LvmR8bN4zrx6HvxUpzCNKFtW4tWh261SWti2Ks9xzb9c9Vp5KA0Z+ZoCyA3NLxP5m9//
         XZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jyZpX9epTT5FK26pIiLWMLzpnn3Jdo8Hr6anKqJcGcw=;
        b=Dl7LfKy536bhYySdQ5HQjVGF15gIJtBTmIApXvlpxidbCK964TZVwevulqxA/+IdUN
         pHK8flQoLxpSQ18Fvxy5o8ib6lcsGMZYH1/WVSmZ1CG39UTUAzfkpB/72RZ8Q1Kb6KdS
         uzh2DUTSRqkWkzRyrZl2nb2gr70Ps1l3GOx20RciHvTLBBFVNYkFVTeMv2N6BP//qDuF
         hgozuuvN6eXbLsL2849l92fh8hEbGS7/FEuKas/tOpBohhRidEbU6vZGaeEcRzTZxW5s
         lnu4SOsgMrCOpm8addmafiKKR4iCtJB5XN+1iMKSQhhSwhmbd7eDe95+cmKh13a2coxk
         Aexw==
X-Gm-Message-State: ANhLgQ0fbqrWYZrTxdKbsSZO4SqmeJMeJJd1HaNopbAc5BVXEU4+DOxm
        bJW1PLqRIGjq7ONwdZ5n1nl+vcwF89A=
X-Google-Smtp-Source: ADFU+vtQGEjlFOAt2D+GeG74pcl8SIAg2SZC4JDLC+7uS/LmizkLIzwEdaebDvPhBOHnpAEgP0VACw==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr29035890wrm.267.1584966582764;
        Mon, 23 Mar 2020 05:29:42 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F66B0.dip0.t-ipconnect.de. [91.63.102.176])
        by smtp.gmail.com with ESMTPSA id j2sm7049484wrs.64.2020.03.23.05.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 05:29:41 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] power: supply: Add support for mps mp2629 battery
 charger
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-5-sravanhome@gmail.com>
 <CAHp75Vf0iAV1g5GV8XoewNEMnGee=_Wkgz=8Y_ym8UPdsb6eFQ@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <9e105e70-a572-aff4-df91-a620e82d3436@gmail.com>
Date:   Mon, 23 Mar 2020 13:29:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf0iAV1g5GV8XoewNEMnGee=_Wkgz=8Y_ym8UPdsb6eFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 23/03/20 12:26 am, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> The mp2629 provides switching-mode battery charge management for
>> single-cell Li-ion or Li-polymer battery. Driver supports the
>> access/control input source and battery charging parameters.
> ...
>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of_device.h>
> Do you need this one?
>
>> +#include <linux/interrupt.h>
>> +#include <linux/iio/consumer.h>
>> +#include <linux/iio/types.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/regmap.h>
> Perhaps put them in order?
>
>> +#include <linux/mfd/core.h>
> How this is being used?
>
>> +#include <linux/mfd/mp2629.h>
> ...
>
>> +#define MP2629_MASK_INPUT_TYPE         0xe0
>> +#define MP2629_MASK_CHARGE_TYPE                0x18
>> +#define MP2629_MASK_CHARGE_CTRL                0x30
>> +#define MP2629_MASK_WDOG_CTRL          0x30
>> +#define MP2629_MASK_IMPEDANCE          0xf0
> GENMASK()?
>
> ...
>
>> +       struct regmap_field *regmap_fields[TERM_CURRENT + 1];
> Hmm... Why not to have a definition to cover + 1?
>
> ...
>
>> +static int mp2629_get_prop(struct mp2629_charger *charger,
>> +                          enum mp2629_field fld,
>> +                          union power_supply_propval *val)
>> +{
>> +       int ret;
>> +       unsigned int rval;
>> +
>> +       ret = regmap_field_read(charger->regmap_fields[fld], &rval);
>> +       if (!ret)
>> +               val->intval = (rval * props[fld].step) + props[fld].min;
>> +
>> +       return ret;
> Why not to use standard pattern, i.e.
>
>    if (ret)
>      return ret;
>    ...
>    return 0;
>
> ?
>
>> +}
> ...
>
>> +static int mp2629_charger_battery_set_prop(struct power_supply *psy,
>> +                                       enum power_supply_property psp,
>> +                                       const union power_supply_propval *val)
>> +{
>> +       struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
>> +       int ret;
> You may replace it with in-place return statements.
>
>> +
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>> +               ret = mp2629_set_prop(charger, TERM_CURRENT, val);
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
>> +               ret = mp2629_set_prop(charger, PRECHARGE, val);
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> +               ret = mp2629_set_prop(charger, CHARGE_VLIM, val);
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +               ret = mp2629_set_prop(charger, CHARGE_ILIM, val);
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return ret;
> ...and drop this completely.
>
>> +}
> ...
>
>> +       case POWER_SUPPLY_PROP_ONLINE:
>> +               ret = regmap_read(charger->regmap, MP2629_REG_STATUS, &rval);
>> +               if (!ret)
>> +                       val->intval = !!(rval & MP2629_MASK_INPUT_TYPE);
>> +               break;
> Traditional pattern?
>
> ...
>
>> +static int mp2629_charger_usb_set_prop(struct power_supply *psy,
>> +                               enum power_supply_property psp,
>> +                               const union power_supply_propval *val)
>> +{
>> +       struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
>> +       int ret;
> No need to have it.
>
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
>> +               ret = mp2629_set_prop(charger, INPUT_VLIM, val);
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +               ret = mp2629_set_prop(charger, INPUT_ILIM, val);
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return ret;
>> +}
> ...
>
>> +       return (psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT ||
>> +               psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT ||
>> +               psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
>> +               psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE);
> Redundant parentheses.
> Ditto for similar cases in the driver.
>
> ...
>
>> +static ssize_t batt_impedance_compensation_show(struct device *dev,
>> +                                          struct device_attribute *attr,
>> +                                          char *buf)
>> +{
>> +       struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
>> +       unsigned int rval;
>> +       int ret;
>> +
>> +       ret = regmap_read(charger->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);
>> +       if (ret < 0)
> ' < 0' is not needed.
> Ditto for other cases.
>
>> +               return ret;
>> +
>> +       rval = (rval >> 4) * 10;
>> +
>> +       return scnprintf(buf, PAGE_SIZE, "%d mohm\n", rval);
> Simple sprintf().
>
>> +}
> ...
>
>> +static ssize_t batt_impedance_compensation_store(struct device *dev,
>> +                                           struct device_attribute *attr,
>> +                                           const char *buf,
>> +                                           size_t count)
>> +{
>> +       struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
>> +       long val;
>> +       int ret;
>> +
>> +       ret = kstrtol(buf, 10, &val);
>> +       if (ret < 0)
> No need to check for negative only.
>
>> +               return ret;
>> +
>> +       if (val < 0 && val > 140)
>> +               return -ERANGE;
> And what the point then to use l instead of ul or even uint variant of
> the conversion above?
>
>> +       /* multiples of 10 mohm so round off */
>> +       val = val / 10;
>> +       ret = regmap_update_bits(charger->regmap, MP2629_REG_IMPEDANCE_COMP,
>> +                                       MP2629_MASK_IMPEDANCE, val << 4);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return count;
>> +}
> ...
>
>> +static int mp2629_charger_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void **pdata = pdev->dev.platform_data;
> Why void?
> Why **?
> Why not to use dev_get_platdata()?
> Why do we need platform data at all?


I have to pass regmap (address) from mfd driver to its children, as per 
review comment previous patch, mfd driver structure should not be 
directly accessed in children.
Please suggest if any other better way

>> +       struct mp2629_charger *charger;
>> +       struct power_supply_config psy_cfg = {0};
>> +       int ret, i;
>> +       charger->regmap = *pdata;
>> +       regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
>> +                               GENMASK(6, 5), (BIT(6) | BIT(5)));
> Too many parentheses.
>
>> +}
> --
> With Best Regards,
> Andy Shevchenko

Thanks,
Saravanan

