Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A8C8D7A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfJBP5m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 11:57:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41924 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJBP5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 11:57:42 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so29571410ioj.8
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7HDf73q4RlIWgNL715WMeMDfk4kVLdtCUlcpTLXCE7w=;
        b=aPNUDLfDLiilzK6w0AGNqCi3jmHPUzXzeHF9Iw5YifRz79FoltwYvbtkGtEvKG/Oaq
         EYbwv3O3nQqGDCEX4rUq/JP9hfvpabZ3WEvvMMsnB75yfEMw4xgXC41IEJIhWJ0yYIyT
         QgirIH7hEuQkAhcaQ73aS57htdaaMpcjPVkOS0Df8Lx7/GumdLvzZaRAh4N9gJ5nM4Pl
         VxEiAT3ETxLrN1nY9XU3bOGRVkAtRm2TGQXj1tqMyhVN4k7NYqqU6NCDkzTNFXlwYNDH
         iYYdpWsUFvek8N5O/MZCVCG0+bJLnHKeJys262GMu1NHj0qGBmwo3GQUJQy0CSOLb8JN
         YgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7HDf73q4RlIWgNL715WMeMDfk4kVLdtCUlcpTLXCE7w=;
        b=oJ9a1n2kpA0Y97qPKD3L/3Zmk5gfH2fDXiv1KIY1sP8Tg+05fnLJIR6qZ9P8FQsGKf
         tRMAJEDDJPRVFM+K0csBzxoM6sujfc1rmTMvubz9CrcXjtAwWJDFmJ+Yq7S1+xP8cHtl
         kZrgp9vH+85UPfIIgyJv72KZ4UwGghaf+DtMp/OTBHQc+69eznmdFFo8OZGwEOsoBSZL
         7gjcYaLeR/5XVtD9G+Vxtyk3lzXJ79/lSxheTxb6Se6BzdzfKXpAfiFsuxduvqEaNYYi
         +dyhxlaNtIHX6tXZoRUNWIAKMFXh/rCeQNYPHq5WRpxoqJdCqPEm0INPgpF51xYxpFSp
         H+kg==
X-Gm-Message-State: APjAAAWoxBfCRiL/xctdryd3Nkc13A7ppZ143JHOvgD0yWcppJOc5ZRs
        jWq2dYDknJjPziL8g6C/FsOQYKu3MvitbYkgl0PHIQ==
X-Google-Smtp-Source: APXvYqyhHKTPsS+3uRHQwZO3JyQGOM8dv0YUEp/vjPP1ABlFVGnrq9TEzU9hkWJ3nckFDvQH7f8PGEzZeTII0oy434Y=
X-Received: by 2002:a92:d184:: with SMTP id z4mr4408206ilz.189.1570031861226;
 Wed, 02 Oct 2019 08:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191002085759.13337-2-brgl@bgdev.pl> <201910022132.qRNFfzjP%lkp@intel.com>
In-Reply-To: <201910022132.qRNFfzjP%lkp@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 2 Oct 2019 17:57:30 +0200
Message-ID: <CAMRc=McpiPT2n2adpUiNGF+iF-gO_B3r7rAGFEA_1YzY0c+6Ww@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: pressure: bmp280: use bulk regulator ops
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

=C5=9Br., 2 pa=C5=BA 2019 o 15:06 kbuild test robot <lkp@intel.com> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on iio/togreg]
> [cannot apply to v5.4-rc1 next-20191002]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/iio-=
pressure-bmp280-code-shrink/20191002-194508
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tog=
reg
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dsh
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/iio/pressure/bmp280-core.c: In function 'bmp280_common_probe':
> >> drivers/iio/pressure/bmp280-core.c:1041:2: error: implicit declaration=
 of function 'regulator_bulk_set_supply_names'; did you mean 'regulator_bul=
k_register_supply_alias'? [-Werror=3Dimplicit-function-declaration]
>      regulator_bulk_set_supply_names(data->supplies,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      regulator_bulk_register_supply_alias
>    cc1: some warnings being treated as errors
>

This function has been introduced in commit d0087e72710c ("regulator:
provide regulator_bulk_set_supply_names()") and released in v5.4-rc1
but it's not present in this tree. In other words: a false positive.

Bart

> vim +1041 drivers/iio/pressure/bmp280-core.c
>
>    986
>    987  int bmp280_common_probe(struct device *dev,
>    988                          struct regmap *regmap,
>    989                          unsigned int chip,
>    990                          const char *name,
>    991                          int irq)
>    992  {
>    993          int ret;
>    994          struct iio_dev *indio_dev;
>    995          struct bmp280_data *data;
>    996          unsigned int chip_id;
>    997          struct gpio_desc *gpiod;
>    998
>    999          indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
>   1000          if (!indio_dev)
>   1001                  return -ENOMEM;
>   1002
>   1003          data =3D iio_priv(indio_dev);
>   1004          mutex_init(&data->lock);
>   1005          data->dev =3D dev;
>   1006
>   1007          indio_dev->dev.parent =3D dev;
>   1008          indio_dev->name =3D name;
>   1009          indio_dev->channels =3D bmp280_channels;
>   1010          indio_dev->info =3D &bmp280_info;
>   1011          indio_dev->modes =3D INDIO_DIRECT_MODE;
>   1012
>   1013          switch (chip) {
>   1014          case BMP180_CHIP_ID:
>   1015                  indio_dev->num_channels =3D 2;
>   1016                  data->chip_info =3D &bmp180_chip_info;
>   1017                  data->oversampling_press =3D ilog2(8);
>   1018                  data->oversampling_temp =3D ilog2(1);
>   1019                  data->start_up_time =3D 10000;
>   1020                  break;
>   1021          case BMP280_CHIP_ID:
>   1022                  indio_dev->num_channels =3D 2;
>   1023                  data->chip_info =3D &bmp280_chip_info;
>   1024                  data->oversampling_press =3D ilog2(16);
>   1025                  data->oversampling_temp =3D ilog2(2);
>   1026                  data->start_up_time =3D 2000;
>   1027                  break;
>   1028          case BME280_CHIP_ID:
>   1029                  indio_dev->num_channels =3D 3;
>   1030                  data->chip_info =3D &bme280_chip_info;
>   1031                  data->oversampling_press =3D ilog2(16);
>   1032                  data->oversampling_humid =3D ilog2(16);
>   1033                  data->oversampling_temp =3D ilog2(2);
>   1034                  data->start_up_time =3D 2000;
>   1035                  break;
>   1036          default:
>   1037                  return -EINVAL;
>   1038          }
>   1039
>   1040          /* Bring up regulators */
> > 1041          regulator_bulk_set_supply_names(data->supplies,
>   1042                                          bmp280_supply_names,
>   1043                                          BMP280_NUM_SUPPLIES);
>   1044
>   1045          ret =3D devm_regulator_bulk_get(dev,
>   1046                                        BMP280_NUM_SUPPLIES, data->=
supplies);
>   1047          if (ret) {
>   1048                  dev_err(dev, "failed to get regulators\n");
>   1049                  return ret;
>   1050          }
>   1051
>   1052          ret =3D regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->=
supplies);
>   1053          if (ret) {
>   1054                  dev_err(dev, "failed to enable regulators\n");
>   1055                  return ret;
>   1056          }
>   1057
>   1058          /* Wait to make sure we started up properly */
>   1059          usleep_range(data->start_up_time, data->start_up_time + 1=
00);
>   1060
>   1061          /* Bring chip out of reset if there is an assigned GPIO l=
ine */
>   1062          gpiod =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   1063          /* Deassert the signal */
>   1064          if (!IS_ERR(gpiod)) {
>   1065                  dev_info(dev, "release reset\n");
>   1066                  gpiod_set_value(gpiod, 0);
>   1067          }
>   1068
>   1069          data->regmap =3D regmap;
>   1070          ret =3D regmap_read(regmap, BMP280_REG_ID, &chip_id);
>   1071          if (ret < 0)
>   1072                  goto out_disable_regulators;
>   1073          if (chip_id !=3D chip) {
>   1074                  dev_err(dev, "bad chip id: expected %x got %x\n",
>   1075                          chip, chip_id);
>   1076                  ret =3D -EINVAL;
>   1077                  goto out_disable_regulators;
>   1078          }
>   1079
>   1080          ret =3D data->chip_info->chip_config(data);
>   1081          if (ret < 0)
>   1082                  goto out_disable_regulators;
>   1083
>   1084          dev_set_drvdata(dev, indio_dev);
>   1085
>   1086          /*
>   1087           * Some chips have calibration parameters "programmed int=
o the devices'
>   1088           * non-volatile memory during production". Let's read the=
m out at probe
>   1089           * time once. They will not change.
>   1090           */
>   1091          if (chip_id  =3D=3D BMP180_CHIP_ID) {
>   1092                  ret =3D bmp180_read_calib(data, &data->calib.bmp1=
80);
>   1093                  if (ret < 0) {
>   1094                          dev_err(data->dev,
>   1095                                  "failed to read calibration coeff=
icients\n");
>   1096                          goto out_disable_regulators;
>   1097                  }
>   1098          } else if (chip_id =3D=3D BMP280_CHIP_ID || chip_id =3D=
=3D BME280_CHIP_ID) {
>   1099                  ret =3D bmp280_read_calib(data, &data->calib.bmp2=
80, chip_id);
>   1100                  if (ret < 0) {
>   1101                          dev_err(data->dev,
>   1102                                  "failed to read calibration coeff=
icients\n");
>   1103                          goto out_disable_regulators;
>   1104                  }
>   1105          }
>   1106
>   1107          /*
>   1108           * Attempt to grab an optional EOC IRQ - only the BMP085 =
has this
>   1109           * however as it happens, the BMP085 shares the chip ID o=
f BMP180
>   1110           * so we look for an IRQ if we have that.
>   1111           */
>   1112          if (irq > 0 || (chip_id  =3D=3D BMP180_CHIP_ID)) {
>   1113                  ret =3D bmp085_fetch_eoc_irq(dev, name, irq, data=
);
>   1114                  if (ret)
>   1115                          goto out_disable_regulators;
>   1116          }
>   1117
>   1118          /* Enable runtime PM */
>   1119          pm_runtime_get_noresume(dev);
>   1120          pm_runtime_set_active(dev);
>   1121          pm_runtime_enable(dev);
>   1122          /*
>   1123           * Set autosuspend to two orders of magnitude larger than=
 the
>   1124           * start-up time.
>   1125           */
>   1126          pm_runtime_set_autosuspend_delay(dev, data->start_up_time=
 / 10);
>   1127          pm_runtime_use_autosuspend(dev);
>   1128          pm_runtime_put(dev);
>   1129
>   1130          ret =3D iio_device_register(indio_dev);
>   1131          if (ret)
>   1132                  goto out_runtime_pm_disable;
>   1133
>   1134
>   1135          return 0;
>   1136
>   1137  out_runtime_pm_disable:
>   1138          pm_runtime_get_sync(data->dev);
>   1139          pm_runtime_put_noidle(data->dev);
>   1140          pm_runtime_disable(data->dev);
>   1141  out_disable_regulators:
>   1142          regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplie=
s);
>   1143          return ret;
>   1144  }
>   1145  EXPORT_SYMBOL(bmp280_common_probe);
>   1146
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
