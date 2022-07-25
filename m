Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0957FA06
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jul 2022 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGYHSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jul 2022 03:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHSV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2022 03:18:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B89DF4B;
        Mon, 25 Jul 2022 00:18:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m7so8008871qkk.6;
        Mon, 25 Jul 2022 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qB3V+u7Q9YEV4g1kg7EbZ66mk5ndHbNPZ0M8bUvZ31c=;
        b=frxGvyzEIET2Q9oamPsAyfvyxiHFszbSm+YZf+q19HvyBYnjUOXE8i/JekhyOSh64P
         NuEvpSpUhDz/BhJiwSRd75Y6UtNbqf7NW+KfaF0dfs8Obhpw+vcJgNG57EKHOoII2jdQ
         HYyrOm0dGlLP0sPeZST5RWci8/jgvK3CFWZuh1lsxsh8hwlgCZuBNuXRjvhswOQQTEAB
         3rlJOEbvccVK2akIaqG/1XRBhbOdRjG1qPD4O0+PbLCNF7cH+iflKkB2kX7dr9OWm1I3
         mdCEW/de3IEZV/Eg1waqWcY8PkkcuDTuCCyPJY+jRIYLOHYdwckvkuD3kTHEqlylXRDS
         +QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qB3V+u7Q9YEV4g1kg7EbZ66mk5ndHbNPZ0M8bUvZ31c=;
        b=Wg93kZJr+Su8xlvgKxVksmGFFSnYTPpGihsLLRGHXTLR+ftzs/LggpL6l+El9lRDec
         kxWoj5hf/6SGvNkxTY4gqVhKLS4WCmZAIlt/c2itDbM65sFjZLg7cVwRJImU+35nZ8wJ
         rUZ0a4B8t2v/wyLxzqi+vmfnKRYklBnX3jQRStBVEXQp847iHk0xIf68LaOnHluIfh3C
         kJKUVp1fEFjeOMCYNjHroBj11ppOtk8OKF81jWwGqRBgwWjiYRZWlI53BqOYpRBBlEtb
         lOq/dU2sApB23Zxc3pEjyXc5u07xkbBUmJKJrXRBKqjHJhMGC5DTfj7j1PdyHUeXTJpS
         P4VA==
X-Gm-Message-State: AJIora/xzAvhJFJGgPSptRDB9bf6XIBMNhNqsI/WOl0MR9g5MGcZG5NX
        Qsylzd3cz1J2P0VcU44QNHt+AS1aC38eslBCRJQ=
X-Google-Smtp-Source: AGRyM1sQr7cmb1Qkot+at32rNTVJswRBvZY4pUgBSQNZDPiar1y7xPCOx+VU9hPTE62sYGu2Tpo3yBaHpFdE1K1jlX0=
X-Received: by 2002:a37:80c2:0:b0:6b5:e9e4:c4c1 with SMTP id
 b185-20020a3780c2000000b006b5e9e4c4c1mr7981575qkd.129.1658733499240; Mon, 25
 Jul 2022 00:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-9-peterwu.pub@gmail.com>
 <1f1a37daf6f3c19a2506f53689c8efbed2b716c3.camel@mediatek.com>
In-Reply-To: <1f1a37daf6f3c19a2506f53689c8efbed2b716c3.camel@mediatek.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Mon, 25 Jul 2022 15:17:43 +0800
Message-ID: <CABtFH5KwY_1EtXHHuiD8we-4RKvzQkueqTF_AQFEeDDv-66EYQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] usb: typec: tcpci_mt6370: Add MediaTek MT6370
 tcpci driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 25, 2022 at 3:06 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Fri, 2022-07-22 at 18:24 +0800, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> >
> > Add support for the Type-C & Power Delivery controller in
> > MediaTek MT6370 IC.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >
> > v6
> > - Convert tcpci as device resource managed with
> > 'devm_add_action_or_reset' API.
> > - Refine remvoe callback.
> > - Refine the commit text from 'This commit add' to 'Add'.
> > ---
> >  drivers/usb/typec/tcpm/Kconfig        |  11 ++
> >  drivers/usb/typec/tcpm/Makefile       |   1 +
> >  drivers/usb/typec/tcpm/tcpci_mt6370.c | 208
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c
> >
> > diff --git a/drivers/usb/typec/tcpm/Kconfig
> > b/drivers/usb/typec/tcpm/Kconfig
> > index 073fd2e..e6b88ca 100644
> > --- a/drivers/usb/typec/tcpm/Kconfig
> > +++ b/drivers/usb/typec/tcpm/Kconfig
> > @@ -35,6 +35,17 @@ config TYPEC_MT6360
> >         USB Type-C. It works with Type-C Port Controller Manager
> >         to provide USB PD and USB Type-C functionalities.
> >
> > +config TYPEC_TCPCI_MT6370
> > +     tristate "MediaTek MT6370 Type-C driver"
> > +     depends on MFD_MT6370
> > +     help
> > +       MediaTek MT6370 is a multi-functional IC that includes
> > +       USB Type-C. It works with Type-C Port Controller Manager
> > +       to provide USB PD and USB Type-C functionalities.
> > +
> > +       This driver can also be built as a module. The module
> > +       will be called "tcpci_mt6370".
> > +
> >  config TYPEC_TCPCI_MAXIM
> >       tristate "Maxim TCPCI based Type-C chip driver"
> >       help
> > diff --git a/drivers/usb/typec/tcpm/Makefile
> > b/drivers/usb/typec/tcpm/Makefile
> > index 7d499f3..906d9dc 100644
> > --- a/drivers/usb/typec/tcpm/Makefile
> > +++ b/drivers/usb/typec/tcpm/Makefile
> > @@ -6,4 +6,5 @@ typec_wcove-y                         := wcove.o
> >  obj-$(CONFIG_TYPEC_TCPCI)            += tcpci.o
> >  obj-$(CONFIG_TYPEC_RT1711H)          += tcpci_rt1711h.o
> >  obj-$(CONFIG_TYPEC_MT6360)           += tcpci_mt6360.o
> > +obj-$(CONFIG_TYPEC_TCPCI_MT6370)     += tcpci_mt6370.o
> >  obj-$(CONFIG_TYPEC_TCPCI_MAXIM)              += tcpci_maxim.o
> > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c
> > b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> > new file mode 100644
> > index 0000000..4f53319
> > --- /dev/null
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> > @@ -0,0 +1,208 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 Richtek Technology Corp.
> > + *
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_wakeup.h>
> > +#include <linux/pm_wakeirq.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/usb/tcpm.h>
> > +#include "tcpci.h"
> > +
> > +#define MT6370_REG_SYSCTRL8  0x9B
> > +
> > +#define MT6370_AUTOIDLE_MASK BIT(3)
> > +
> > +#define MT6370_VENDOR_ID     0x29CF
> > +#define MT6370_TCPC_DID_A    0x2170
> > +
> > +struct mt6370_priv {
> > +     struct device *dev;
> > +     struct regulator *vbus;
> > +     struct tcpci *tcpci;
> > +     struct tcpci_data tcpci_data;
> > +};
> > +
> > +static const struct reg_sequence mt6370_reg_init[] = {
> > +     REG_SEQ(0xA0, 0x1, 1000),
> > +     REG_SEQ(0x81, 0x38, 0),
> > +     REG_SEQ(0x82, 0x82, 0),
> > +     REG_SEQ(0xBA, 0xFC, 0),
> > +     REG_SEQ(0xBB, 0x50, 0),
> > +     REG_SEQ(0x9E, 0x8F, 0),
> > +     REG_SEQ(0xA1, 0x5, 0),
> > +     REG_SEQ(0xA2, 0x4, 0),
> > +     REG_SEQ(0xA3, 0x4A, 0),
> > +     REG_SEQ(0xA4, 0x01, 0),
> > +     REG_SEQ(0x95, 0x01, 0),
> > +     REG_SEQ(0x80, 0x71, 0),
> > +     REG_SEQ(0x9B, 0x3A, 1000),
> > +};
> > +
> > +static int mt6370_tcpc_init(struct tcpci *tcpci, struct tcpci_data
> > *data)
> > +{
> > +     u16 did;
> > +     int ret;
> > +
> > +     ret = regmap_register_patch(data->regmap, mt6370_reg_init,
> > +                                 ARRAY_SIZE(mt6370_reg_init));
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_raw_read(data->regmap, TCPC_BCD_DEV, &did,
> > sizeof(u16));
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (did == MT6370_TCPC_DID_A)
> > +             return regmap_write(data->regmap, TCPC_FAULT_CTRL,
> > 0x80);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt6370_tcpc_set_vconn(struct tcpci *tcpci, struct
> > tcpci_data *data,
> > +                              bool enable)
> > +{
> > +     return regmap_update_bits(data->regmap, MT6370_REG_SYSCTRL8,
> > +                               MT6370_AUTOIDLE_MASK,
> > +                               !enable ? MT6370_AUTOIDLE_MASK : 0);
> > +}
> > +
> > +static int mt6370_tcpc_set_vbus(struct tcpci *tcpci, struct
> > tcpci_data *data,
> > +                             bool source, bool sink)
> @sink is not used in this function?

Hi Chunfeng,
The default HW binding is using the mt6370 switching charger.
Due to the switching charger design, 'src usb boost' and 'sink battery
charger', only one can be used at the same time.
Thanks.

>
> > +{
> > +     struct mt6370_priv *priv = container_of(data, struct
> > mt6370_priv,
> > +                                             tcpci_data);
> > +     int ret;
> > +
> > +     ret = regulator_is_enabled(priv->vbus);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (ret && !source)
> > +             return regulator_disable(priv->vbus);
> > +
> > +     if (!ret && source)
> > +             return regulator_enable(priv->vbus);
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t mt6370_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct mt6370_priv *priv = dev_id;
> > +
> > +     return tcpci_irq(priv->tcpci);
> > +}
> > +
> > +static int mt6370_check_vendor_info(struct mt6370_priv *priv)
> > +{
> > +     struct regmap *regmap = priv->tcpci_data.regmap;
> > +     u16 vid;
> > +     int ret;
> > +
> > +     ret = regmap_raw_read(regmap, TCPC_VENDOR_ID, &vid,
> > sizeof(u16));
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (vid != MT6370_VENDOR_ID)
> > +             return dev_err_probe(priv->dev, -ENODEV,
> > +                                  "Vendor ID not correct 0x%02x\n",
> > vid);
> > +
> > +     return 0;
> > +}
> > +
> > +static void mt6370_unregister_tcpci_port(void *tcpci)
> > +{
> > +     tcpci_unregister_port(tcpci);
> > +}
> > +
> > +static int mt6370_tcpc_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6370_priv *priv;
> > +     struct device *dev = &pdev->dev;
> > +     int irq, ret;
> > +
> > +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->dev = dev;
> > +
> > +     priv->tcpci_data.regmap = dev_get_regmap(dev->parent, NULL);
> > +     if (!priv->tcpci_data.regmap)
> > +             return dev_err_probe(dev, -ENODEV, "Failed to init
> > regmap\n");
> > +
> > +     ret = mt6370_check_vendor_info(priv);
> > +     if (ret)
> > +             return ret;
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return dev_err_probe(dev, irq, "Failed to get irq\n");
> > +
> > +     /* Assign TCPCI feature and ops */
> > +     priv->tcpci_data.auto_discharge_disconnect = 1;
> > +     priv->tcpci_data.init = mt6370_tcpc_init;
> > +     priv->tcpci_data.set_vconn = mt6370_tcpc_set_vconn;
> > +
> > +     priv->vbus = devm_regulator_get_optional(dev, "vbus");
> > +     if (!IS_ERR(priv->vbus))
> > +             priv->tcpci_data.set_vbus = mt6370_tcpc_set_vbus;
> > +
> > +     priv->tcpci = tcpci_register_port(dev, &priv->tcpci_data);
> > +     if (IS_ERR(priv->tcpci))
> > +             return dev_err_probe(dev, PTR_ERR(priv->tcpci),
> > +                                  "Failed to register tcpci
> > port\n");
> > +
> > +     ret = devm_add_action_or_reset(dev,
> > mt6370_unregister_tcpci_port,
> > +                                    priv->tcpci);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_request_threaded_irq(dev, irq, NULL,
> > mt6370_irq_handler,
> > +                                     IRQF_ONESHOT, dev_name(dev),
> > priv);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to allocate
> > irq\n");
> > +
> > +     device_init_wakeup(dev, true);
> > +     dev_pm_set_wake_irq(dev, irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt6370_tcpc_remove(struct platform_device *pdev)
> > +{
> > +     dev_pm_clear_wake_irq(&pdev->dev);
> > +     device_init_wakeup(&pdev->dev, false);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id mt6370_tcpc_devid_table[] = {
> > +     { .compatible = "mediatek,mt6370-tcpc" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6370_tcpc_devid_table);
> > +
> > +static struct platform_driver mt6370_tcpc_driver = {
> > +     .driver = {
> > +             .name = "mt6370-tcpc",
> > +             .of_match_table = mt6370_tcpc_devid_table,
> > +     },
> > +     .probe = mt6370_tcpc_probe,
> > +     .remove = mt6370_tcpc_remove,
> > +};
> > +module_platform_driver(mt6370_tcpc_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("MT6370 USB Type-C Port Controller Interface
> > Driver");
> > +MODULE_LICENSE("GPL v2");
>


-- 
Best Regards,
ChiaEn Wu
