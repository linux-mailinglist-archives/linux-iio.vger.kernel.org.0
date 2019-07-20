Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA46EF9B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2019 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGTOOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jul 2019 10:14:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36884 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbfGTOOE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jul 2019 10:14:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so25415506qkl.4
        for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2019 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjy01hz76qJsGBlj89nPeHsxAVMf/NWX8i7ANc3NyP4=;
        b=I+ScoAv8q6Te/9p4Qm1WL3NsGcfq1HXumf4DYD5boY31ZFYqRutFNJ1S92hcXfaKdW
         ySGkDcfSmbEzvu3bCYyoyAniE54YCEDSk197kKGmTg4uC1O/yTTF/2skSaI2wwX6wvoy
         /UYRUWxI/jlJK8siKJrmwj689HohB+ApkpM7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjy01hz76qJsGBlj89nPeHsxAVMf/NWX8i7ANc3NyP4=;
        b=Ysil8TiSjKOMoNEJfXlWbtzRa5wHcL4em1lh+uztrPvFac6mPr2PN8N2FtPun2dvFz
         Urf4kVzWveaSVvxq88G5XMxGZMa8Bywjs8hqwA4M1DcBUcRWBGdYRFzzbCRAELtax2hw
         e3a+nfsBaGto+FSLusww0NZ9MMHR6unRH3FixDaIPiODuNmaIimgVrLkxQk5WmdB4lax
         uSm6qiVPHwC6FOQVCaiJ0OMaD8ZrEyoL4hPppOSTyTrxXImC2ht/09Ccrtd34+OuKLcD
         e0XuU7/NZTCArnVD3UsP6GViBUke7RqTK79s1goPU6iQoQKtnhnjwgDhIRAv1dXS26//
         OCoA==
X-Gm-Message-State: APjAAAXS3f2bVNSwp7dyvlbaRJFWO+kgdk+VO53A5TQ2m6awd+0k/oBN
        8s31/EC0qz543ihNEuNWY4YJSFHYx3iLD2W6I2i+xQ==
X-Google-Smtp-Source: APXvYqwPDOsBteUqw3hytvAK4uoJj9IbndzbKZU8k0iNDt6pOzdf6KeidqoUr+AO9CQpwMmx2+ZqXLUueG4APAXdP9E=
X-Received: by 2002:ae9:f017:: with SMTP id l23mr39448045qkg.457.1563632043392;
 Sat, 20 Jul 2019 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190718080119.30707-1-zhiyong.tao@mediatek.com> <20190718080119.30707-3-zhiyong.tao@mediatek.com>
In-Reply-To: <20190718080119.30707-3-zhiyong.tao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 20 Jul 2019 22:13:51 +0800
Message-ID: <CANMq1KBzLjshQGqfULdPFbzzYxMx2+T+Ku6B4j0QoFRhgsP_nw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] auxadc: mediatek: support efuse calibration in
 auxadc driver
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, jic23@kernel.org,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        pmeerw@pmeerw.net, srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, jg_poxu@mediatek.com, sj.huang@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-iio@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 18, 2019 at 4:01 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch support efuse calibration in auxadc driver
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: jg_poxu <jg_poxu@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 95d76abb64ec..e30d9736b1a5 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -17,12 +17,14 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/iopoll.h>
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
> +#include <linux/slab.h>
>
>  /* Register definitions */
>  #define MT6577_AUXADC_CON0                    0x00
> @@ -42,6 +44,13 @@
>  #define MT6577_AUXADC_POWER_READY_MS          1
>  #define MT6577_AUXADC_SAMPLE_READY_US         25
>
> +#define ADC_GE_A_SHIFT      10
> +#define ADC_GE_A_MASK       (0x3ff << ADC_GE_A_SHIFT)
> +#define ADC_OE_A_SHIFT      0
> +#define ADC_OE_A_MASK       (0x3ff << ADC_OE_A_SHIFT)
> +#define ADC_CALI_EN_A_SHIFT 20
> +#define ADC_CALI_EN_A_MASK  (0x1 << ADC_CALI_EN_A_SHIFT)
> +
>  struct mt6577_auxadc_device {
>         void __iomem *reg_base;
>         struct clk *adc_clk;
> @@ -74,6 +83,64 @@ static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
>         MT6577_AUXADC_CHANNEL(15),
>  };
>
> +s32 cali_oe;
> +s32 cali_ge;

Why do you need these 2 (global) variables? They are set in
mt6577_auxadc_update_cali but never read anywhere.

> +struct adc_cali_info {
> +       u32 cali_ge_a;
> +       u32 cali_oe_a;
> +       u32 gain;
> +};
> +static struct adc_cali_info adc_cali;

This should be inside struct mt6577_auxadc_device structure. And... I
still do not understand what this does, since nothing reads back
adc_cali either...

On gerrit (https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1624410),
you mentioned that thermal module will use these, can you please
upload these changes as part of this series, so that we can review the
whole thing in one piece (and understand better how to fix this
interface).

> +
> +static int mt6577_auxadc_update_cali(struct device *dev)
> +{
> +       struct nvmem_cell *cell;
> +       u32 *buf;
> +       size_t len;
> +       int ret = 0;
> +
> +       cali_oe = 0;
> +       cali_ge = 0;
> +
> +       cell = nvmem_cell_get(dev, "calibration-data");
> +       if (IS_ERR(cell)) {
> +               if (PTR_ERR(cell) == -EPROBE_DEFER)
> +                       return PTR_ERR(cell);
> +               return 0;
> +       }
> +
> +       buf = (u32 *)nvmem_cell_read(cell, &len);

Cast is not necessary.

> +
> +       nvmem_cell_put(cell);
> +
> +       if (IS_ERR(buf))
> +               return PTR_ERR(buf);
> +
> +       if (len < sizeof(u32)) {
> +               dev_warn(dev, "invalid calibration data\n");
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       if (((buf[0] & ADC_CALI_EN_A_MASK) >> ADC_CALI_EN_A_SHIFT) != 0) {
> +               adc_cali.cali_oe_a =
> +                       (buf[0] & ADC_OE_A_MASK) >> ADC_OE_A_SHIFT;
> +               adc_cali.cali_ge_a =
> +                       ((buf[0] & ADC_GE_A_MASK) >> ADC_GE_A_SHIFT);
> +
> +               cali_ge = adc_cali.cali_ge_a - 512;
> +               cali_oe = adc_cali.cali_oe_a - 512;
> +               adc_cali.gain = 1 + cali_ge;
> +       }  else {
> +               dev_info(dev, "Device not calibrated, using default calibration values\n");
> +       }
> +
> +out:
> +       kfree(buf);
> +
> +       return ret;
> +}
> +
>  static inline void mt6577_auxadc_mod_reg(void __iomem *reg,
>                                          u32 or_mask, u32 and_mask)
>  {
> @@ -274,6 +341,10 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>                 goto err_power_off;
>         }
>
> +       ret = mt6577_auxadc_update_cali(&pdev->dev);
> +       if (ret)
> +               return ret;
> +
>         return 0;

Or just
return mt6577_auxadc_update_cali(&pdev->dev);

>
>  err_power_off:
> --
> 2.12.5
>
