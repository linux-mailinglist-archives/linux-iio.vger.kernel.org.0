Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B159B588
	for <lists+linux-iio@lfdr.de>; Sun, 21 Aug 2022 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiHUQyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Aug 2022 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUQyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2022 12:54:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738D1D31C
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 09:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F62CB80B94
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 16:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98AAC433D6;
        Sun, 21 Aug 2022 16:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661100889;
        bh=NkjQ6eehMZAgZzstl0Ztj1bVamGiPxGc7DGg32Xs7ag=;
        h=From:To:Cc:Subject:Date:From;
        b=eZiQlf/xn8ysfgSq65BirBGsy/llp4ZViJHM5WOyYyque4HOlRbk0lqv21k1IPWmp
         hjeyT1Qyn3p4E7O2GxrSVvMfzRcFRAYgIiL6FqANCfuw+MwGGSUHXfMv32pedrftOh
         TqymE4sDyA94whR+CGg4dfrtcLMaWGUnMoDGEHLRRPQqcs3jMQC2iK+iZavfDQzmcd
         h2ZTrD1s9JLfiiAOK+IVQ8Bz3L+0XgF6EirOvj+XtAhIQsX55+wmohJIUmvYsZTfEE
         /q2TKR76iUxN3rkbaHe0WOvs9+zHSwC7RmiVggMeko+afrX79g/rPmDAzuhK13GbFz
         qF6xVYyqBnhxw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: consumer: Mark struct iio_channel parameter to iio_get_channel_type() const
Date:   Sun, 21 Aug 2022 17:20:17 +0100
Message-Id: <20220821162017.2207710-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This accessor is only reading data via this pointer, so make the fact
it is const explicit.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

Used in a clean up to sound/soc/samsung/aries_wm8994 where
the struct iio_channel pointer is marked const.

---
 drivers/extcon/extcon-adc-jack.c              |  1 +
 drivers/hwmon/iio_hwmon.c                     |  1 +
 drivers/hwmon/ntc_thermistor.c                |  1 +
 drivers/iio/adc/axp20x_adc.c                  |  1 +
 drivers/iio/adc/axp288_adc.c                  |  1 +
 drivers/iio/adc/da9150-gpadc.c                |  1 +
 drivers/iio/adc/envelope-detector.c           |  2 +
 drivers/iio/adc/intel_mrfld_adc.c             |  1 +
 drivers/iio/adc/lp8788_adc.c                  |  1 +
 drivers/iio/adc/ltc2497-core.c                |  1 +
 drivers/iio/adc/mp2629_adc.c                  |  1 +
 drivers/iio/adc/rn5t618-adc.c                 |  1 +
 drivers/iio/adc/sun4i-gpadc-iio.c             |  1 +
 drivers/iio/afe/iio-rescale.c                 |  1 +
 drivers/iio/buffer/industrialio-buffer-cb.c   |  1 +
 drivers/iio/buffer/industrialio-hw-consumer.c |  1 +
 drivers/iio/dac/dpot-dac.c                    |  1 +
 drivers/iio/dac/m62332.c                      |  1 +
 drivers/iio/inkern.c                          | 58 +++++++++----------
 drivers/iio/light/cm3605.c                    |  1 +
 drivers/iio/light/gp2ap002.c                  |  1 +
 drivers/iio/multiplexer/iio-mux.c             |  1 +
 drivers/iio/potentiostat/lmp91000.c           |  1 +
 drivers/input/joystick/adc-joystick.c         |  1 +
 drivers/input/keyboard/adc-keys.c             |  1 +
 drivers/input/touchscreen/colibri-vf50-ts.c   |  1 +
 .../input/touchscreen/resistive-adc-touch.c   |  1 +
 drivers/phy/motorola/phy-cpcap-usb.c          |  1 +
 drivers/power/supply/ab8500_btemp.c           |  1 +
 drivers/power/supply/axp20x_ac_power.c        |  1 +
 drivers/power/supply/axp20x_battery.c         |  1 +
 drivers/power/supply/axp20x_usb_power.c       |  1 +
 drivers/power/supply/axp288_fuel_gauge.c      |  1 +
 drivers/power/supply/cpcap-battery.c          |  1 +
 drivers/power/supply/cpcap-charger.c          |  1 +
 drivers/power/supply/da9150-charger.c         |  1 +
 drivers/power/supply/generic-adc-battery.c    |  1 +
 drivers/power/supply/ingenic-battery.c        |  1 +
 drivers/power/supply/lego_ev3_battery.c       |  1 +
 drivers/power/supply/lp8788-charger.c         |  1 +
 drivers/power/supply/mp2629_charger.c         |  1 +
 drivers/power/supply/rn5t618_power.c          |  1 +
 drivers/power/supply/rx51_battery.c           |  1 +
 drivers/power/supply/sc27xx_fuel_gauge.c      |  1 +
 drivers/power/supply/twl4030_charger.c        |  1 +
 drivers/power/supply/twl4030_madc_battery.c   |  1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |  1 +
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |  1 +
 drivers/thermal/thermal-generic-adc.c         |  1 +
 include/linux/iio/consumer.h                  |  2 +-
 sound/soc/samsung/aries_wm8994.c              |  1 +
 sound/soc/stm/stm32_adfsdm.c                  |  1 +
 52 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 0317b614b680..1af96a12f396 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -208,3 +208,4 @@ module_platform_driver(adc_jack_driver);
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("ADC Jack extcon driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 580a7d125b88..934faf3f5ff1 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -182,3 +182,4 @@ module_platform_driver(iio_hwmon_driver);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("IIO to hwmon driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 9c9e9f4ccb9e..ee6e6a806040 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -706,3 +706,4 @@ MODULE_DESCRIPTION("NTC Thermistor Driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ntc-thermistor");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 53bf7d4899d2..d62f5b3e2c95 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -775,3 +775,4 @@ module_platform_driver(axp20x_adc_driver);
 MODULE_DESCRIPTION("ADC driver for AXP20X and AXP22X PMICs");
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 580361bd9849..d4eb0bffbfe0 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -312,3 +312,4 @@ module_platform_driver(axp288_adc_driver);
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("X-Powers AXP288 ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 8f0d3fb63b67..51a86e0d2e8b 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -373,3 +373,4 @@ module_platform_driver(da9150_gpadc_driver);
 MODULE_DESCRIPTION("GPADC Driver for DA9150");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index e911c25d106d..c5a93a1d5cd3 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -406,3 +406,5 @@ module_platform_driver(envelope_detector_driver);
 MODULE_DESCRIPTION("Envelope detector using a DAC and a comparator");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
+
diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 7263ad76124d..613c1acca1f1 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -240,3 +240,4 @@ MODULE_AUTHOR("Vincent Pelletier <plr.vincent@gmail.com>");
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("ADC driver for Basin Cove PMIC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 6d9b354bc705..5813416ab767 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -225,3 +225,4 @@ MODULE_DESCRIPTION("Texas Instruments LP8788 ADC Driver");
 MODULE_AUTHOR("Milo Kim");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:lp8788-adc");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2a485c8a1940..9b19cdf1dc3b 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -236,3 +236,4 @@ EXPORT_SYMBOL_NS(ltc2497core_remove, LTC2497);
 
 MODULE_DESCRIPTION("common code for LTC2496/LTC2497 drivers");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 30a31f185d08..f6d4b10793bc 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -206,3 +206,4 @@ module_platform_driver(mp2629_adc_driver);
 MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
 MODULE_DESCRIPTION("MP2629 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 6bf32907f01d..f5d46d044c60 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -260,3 +260,4 @@ module_platform_driver(rn5t618_adc_driver);
 MODULE_ALIAS("platform:rn5t618-adc");
 MODULE_DESCRIPTION("RICOH RN5T618 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..f8237a959dd6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -714,3 +714,4 @@ module_platform_driver(sun4i_gpadc_driver);
 MODULE_DESCRIPTION("ADC driver for sunxi platforms");
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1f280c360701..e8d9dfe2fe61 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -598,3 +598,4 @@ module_platform_driver(rescale_driver);
 MODULE_DESCRIPTION("IIO rescale driver");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 1357255c3cd9..4a6c932b6b53 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -154,3 +154,4 @@ EXPORT_SYMBOL_NS_GPL(iio_channel_cb_get_iio_dev, IIO_CONSUMER);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O callback buffer");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index fb58f599a80b..c79044b0cd95 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -211,3 +211,4 @@ EXPORT_SYMBOL_GPL(iio_hw_consumer_disable);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Hardware consumer buffer the IIO framework");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 83ce9489259c..6eb174ac1724 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -256,3 +256,4 @@ module_platform_driver(dpot_dac_driver);
 MODULE_DESCRIPTION("DAC emulation driver using a digital potentiometer");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 22b02f50fe41..19b82ec9ff29 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -250,3 +250,4 @@ module_i2c_driver(m62332_driver);
 MODULE_AUTHOR("Dmitry Eremin-Solenikov");
 MODULE_DESCRIPTION("M62332 8-bit DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MACHINE);
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..768c344710b3 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -67,7 +67,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_map_array_register);
+EXPORT_SYMBOL_NS_GPL(iio_map_array_register, IIO_MACHINE);
 
 /*
  * Remove all map entries associated with the given iio device
@@ -82,7 +82,7 @@ int iio_map_array_unregister(struct iio_dev *indio_dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_map_array_unregister);
+EXPORT_SYMBOL_NS_GPL(iio_map_array_unregister, IIO_MACHINE);
 
 static void iio_map_array_unregister_cb(void *indio_dev)
 {
@@ -99,7 +99,7 @@ int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev, s
 
 	return devm_add_action_or_reset(dev, iio_map_array_unregister_cb, indio_dev);
 }
-EXPORT_SYMBOL_GPL(devm_iio_map_array_register);
+EXPORT_SYMBOL_NS_GPL(devm_iio_map_array_register, IIO_MACHINE);
 
 static const struct iio_chan_spec
 *iio_chan_spec_from_name(const struct iio_dev *indio_dev, const char *name)
@@ -285,7 +285,7 @@ struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
 
 	return ERR_PTR(-ENODEV);
 }
-EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);
+EXPORT_SYMBOL_NS_GPL(fwnode_iio_channel_get_by_name, IIO_CONSUMER);
 
 static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 {
@@ -393,7 +393,7 @@ struct iio_channel *iio_channel_get(struct device *dev,
 
 	return iio_channel_get_sys(name, channel_name);
 }
-EXPORT_SYMBOL_GPL(iio_channel_get);
+EXPORT_SYMBOL_NS_GPL(iio_channel_get, IIO_CONSUMER);
 
 void iio_channel_release(struct iio_channel *channel)
 {
@@ -402,7 +402,7 @@ void iio_channel_release(struct iio_channel *channel)
 	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
-EXPORT_SYMBOL_GPL(iio_channel_release);
+EXPORT_SYMBOL_NS_GPL(iio_channel_release, IIO_CONSUMER);
 
 static void devm_iio_channel_free(void *iio_channel)
 {
@@ -425,7 +425,7 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 
 	return channel;
 }
-EXPORT_SYMBOL_GPL(devm_iio_channel_get);
+EXPORT_SYMBOL_NS_GPL(devm_iio_channel_get, IIO_CONSUMER);
 
 struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 							struct fwnode_handle *fwnode,
@@ -444,7 +444,7 @@ struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 
 	return channel;
 }
-EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
+EXPORT_SYMBOL_NS_GPL(devm_fwnode_iio_channel_get_by_name, IIO_CONSUMER);
 
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
@@ -521,7 +521,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(iio_channel_get_all);
+EXPORT_SYMBOL_NS_GPL(iio_channel_get_all, IIO_CONSUMER);
 
 void iio_channel_release_all(struct iio_channel *channels)
 {
@@ -533,7 +533,7 @@ void iio_channel_release_all(struct iio_channel *channels)
 	}
 	kfree(channels);
 }
-EXPORT_SYMBOL_GPL(iio_channel_release_all);
+EXPORT_SYMBOL_NS_GPL(iio_channel_release_all, IIO_CONSUMER);
 
 static void devm_iio_channel_free_all(void *iio_channels)
 {
@@ -556,7 +556,7 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
 
 	return channels;
 }
-EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
+EXPORT_SYMBOL_NS_GPL(devm_iio_channel_get_all, IIO_CONSUMER);
 
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
@@ -603,7 +603,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_raw, IIO_CONSUMER);
 
 int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 {
@@ -622,7 +622,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_average_raw, IIO_CONSUMER);
 
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 						 int raw, int *processed,
@@ -722,7 +722,7 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
+EXPORT_SYMBOL_NS_GPL(iio_convert_raw_to_processed, IIO_CONSUMER);
 
 int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 			       enum iio_chan_info_enum attribute)
@@ -742,13 +742,13 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_attribute, IIO_CONSUMER);
 
 int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 {
 	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_OFFSET);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_offset);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_offset, IIO_CONSUMER);
 
 int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 				     unsigned int scale)
@@ -781,20 +781,20 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_processed_scale, IIO_CONSUMER);
 
 int iio_read_channel_processed(struct iio_channel *chan, int *val)
 {
 	/* This is just a special case with scale factor 1 */
 	return iio_read_channel_processed_scale(chan, val, 1);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_processed);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_processed, IIO_CONSUMER);
 
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 {
 	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_SCALE);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_scale);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_scale, IIO_CONSUMER);
 
 static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
@@ -826,7 +826,7 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_read_avail_channel_attribute, IIO_CONSUMER);
 
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length)
@@ -843,7 +843,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_avail_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_avail_channel_raw, IIO_CONSUMER);
 
 static int iio_channel_read_max(struct iio_channel *chan,
 				int *val, int *val2, int *type,
@@ -910,9 +910,9 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_max_channel_raw, IIO_CONSUMER);
 
-int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
+int iio_get_channel_type(const struct iio_channel *chan, enum iio_chan_type *type)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
 	int ret = 0;
@@ -930,7 +930,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_get_channel_type);
+EXPORT_SYMBOL_NS_GPL(iio_get_channel_type, IIO_CONSUMER);
 
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
@@ -957,13 +957,13 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_attribute, IIO_CONSUMER);
 
 int iio_write_channel_raw(struct iio_channel *chan, int val)
 {
 	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_raw, IIO_CONSUMER);
 
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 {
@@ -978,7 +978,7 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 
 	return i;
 }
-EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
+EXPORT_SYMBOL_NS_GPL(iio_get_channel_ext_info_count, IIO_CONSUMER);
 
 static const struct iio_chan_spec_ext_info *
 iio_lookup_ext_info(const struct iio_channel *chan, const char *attr)
@@ -1008,7 +1008,7 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
 	return ext_info->read(chan->indio_dev, ext_info->private,
 			      chan->channel, buf);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_ext_info, IIO_CONSUMER);
 
 ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 				   const char *buf, size_t len)
@@ -1022,4 +1022,4 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 	return ext_info->write(chan->indio_dev, ext_info->private,
 			       chan->channel, buf, len);
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_ext_info, IIO_CONSUMER);
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index c721b69d5095..d87d61efb88d 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -325,3 +325,4 @@ module_platform_driver(cm3605_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("CM3605 ambient light and proximity sensor driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index e2707416f9a8..8780dc4ff967 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -722,3 +722,4 @@ module_i2c_driver(gp2ap002_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("GP2AP002 ambient light and proximity sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 93558fddfa9b..7760e673254a 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -459,3 +459,4 @@ module_platform_driver(mux_driver);
 MODULE_DESCRIPTION("IIO multiplexer driver");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index fe514f0b5506..d42627bdeed0 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -428,3 +428,4 @@ module_i2c_driver(lmp91000_driver);
 MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("LMP91000 digital potentiostat");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index e0cfdc84763f..d52d7e6c9d90 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -263,3 +263,4 @@ module_platform_driver(adc_joystick_driver);
 MODULE_DESCRIPTION("Input driver for joysticks connected over ADC");
 MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index bf72ab8df817..8196b101fac4 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -205,3 +205,4 @@ module_platform_driver(adc_keys_driver);
 MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
 MODULE_DESCRIPTION("Input driver for resistor ladder connected on ADC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index aa829725ded7..da765959d6fb 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -376,3 +376,4 @@ module_platform_driver(vf50_touch_driver);
 MODULE_AUTHOR("Sanchayan Maity");
 MODULE_DESCRIPTION("Colibri VF50 Touchscreen driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index 6f754a8d30b1..c6c04ae331c3 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -305,3 +305,4 @@ module_platform_driver(grts_driver);
 MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
 MODULE_DESCRIPTION("Generic ADC Resistive Touch Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 2f8210167b77..d0d6b79002f8 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -726,3 +726,4 @@ MODULE_ALIAS("platform:cpcap_usb");
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP usb phy driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 863fabe05bdc..3305b54a63c5 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -834,3 +834,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski, Arun R Murthy");
 MODULE_ALIAS("platform:ab8500-btemp");
 MODULE_DESCRIPTION("AB8500 battery temperature driver");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 57e50208d537..d81bfae31bf2 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -422,3 +422,4 @@ module_platform_driver(axp20x_ac_power_driver);
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_DESCRIPTION("AXP20X and AXP22X PMICs' AC power supply driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..5864990667d8 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -658,3 +658,4 @@ module_platform_driver(axp20x_batt_driver);
 MODULE_DESCRIPTION("Battery power supply driver for AXP20X and AXP22X PMICs");
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..521b128130ea 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -688,3 +688,4 @@ module_platform_driver(axp20x_usb_power_driver);
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("AXP20x PMIC USB power supply status driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 8e6f8a655079..97e40a6874a7 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -805,3 +805,4 @@ MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
 MODULE_AUTHOR("Todd Brandt <todd.e.brandt@linux.intel.com>");
 MODULE_DESCRIPTION("Xpower AXP288 Fuel Gauge Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index d98d9244e394..a13dc92ca1d2 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1178,3 +1178,4 @@ module_platform_driver(cpcap_battery_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP PMIC Battery Driver");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 60e0ce105a29..9fba11122e28 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -988,3 +988,4 @@ MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP Battery Charger Interface driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:cpcap-charger");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index f9314cc0cd75..1dd71f19ac0a 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -688,3 +688,4 @@ module_platform_driver(da9150_charger_driver);
 MODULE_DESCRIPTION("Charger Driver for DA9150");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 66039c665dd1..0623c51a3cff 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -415,3 +415,4 @@ module_platform_driver(gab_driver);
 MODULE_AUTHOR("anish kumar <anish198519851985@gmail.com>");
 MODULE_DESCRIPTION("generic battery driver using IIO");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 2e7fdfde47ec..0edb9997cc73 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -188,3 +188,4 @@ module_platform_driver(ingenic_battery_driver);
 MODULE_DESCRIPTION("Battery driver for Ingenic JZ47xx SoCs");
 MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index ccb00be38e2c..3438b25e214c 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -230,3 +230,4 @@ module_platform_driver(lego_ev3_battery_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Lechner <david@lechnology.com>");
 MODULE_DESCRIPTION("LEGO MINDSTORMS EV3 Battery Driver");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 56c57529c228..296fc162de89 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -739,3 +739,4 @@ MODULE_DESCRIPTION("TI LP8788 Charger Driver");
 MODULE_AUTHOR("Milo Kim");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:lp8788-charger");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index bf9c27b463a8..087e1e8795c5 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -665,3 +665,4 @@ module_platform_driver(mp2629_charger_driver);
 MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
 MODULE_DESCRIPTION("MP2629 Charger driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index a5e09ac78a50..2a08fb017421 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -827,3 +827,4 @@ module_platform_driver(rn5t618_power_driver);
 MODULE_ALIAS("platform:rn5t618-power");
 MODULE_DESCRIPTION("Power supply driver for RICOH RN5T618");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index 6e488ecf4dcb..823f335ceb28 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -281,3 +281,4 @@ MODULE_ALIAS("platform:rx51-battery");
 MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Nokia RX-51 battery driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 632977f84b95..26d4632bac17 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1355,3 +1355,4 @@ module_platform_driver(sc27xx_fgu_driver);
 
 MODULE_DESCRIPTION("Spreadtrum SC27XX PMICs Fual Gauge Unit Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1bc49b2e12e8..9cc457d7fc43 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1148,3 +1148,4 @@ MODULE_AUTHOR("Gražvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030_bci");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 48649dcfe3a9..86aba16c45cf 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -276,3 +276,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lukas Märdian <lukas@goldelico.com>");
 MODULE_DESCRIPTION("twl4030_madc battery driver");
 MODULE_ALIAS("platform:twl4030_madc_battery");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 0a78053cb798..c7d230dbac69 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1082,3 +1082,4 @@ module_platform_driver(adc_tm5_driver);
 
 MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 770f82cc9bca..9a4d994ea8ab 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -491,3 +491,4 @@ module_platform_driver(qpnp_tm_driver);
 MODULE_ALIAS("platform:spmi-temp-alarm");
 MODULE_DESCRIPTION("QPNP PMIC Temperature Alarm driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..7f86615b6b62 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -176,3 +176,4 @@ module_platform_driver(gadc_thermal_driver);
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_DESCRIPTION("Generic ADC thermal driver using IIO framework with DT");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..a73c67baae2a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -335,7 +335,7 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
  *
  * returns the enum iio_chan_type of the channel
  */
-int iio_get_channel_type(struct iio_channel *channel,
+int iio_get_channel_type(const struct iio_channel *channel,
 			 enum iio_chan_type *type);
 
 /**
diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 0fbbf3b02c09..f6a9d1af6932 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -695,3 +695,4 @@ module_platform_driver(aries_audio_driver);
 MODULE_DESCRIPTION("ALSA SoC ARIES WM8994");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:aries-audio-wm8994");
+MODULE_IMPORT_NS(IIO_CONSUMER);
diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 04f2912e1418..fc95dcc82e9b 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -396,3 +396,4 @@ MODULE_DESCRIPTION("stm32 DFSDM DAI driver");
 MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" STM32_ADFSDM_DRV_NAME);
+MODULE_IMPORT_NS(IIO_CONSUMER);
-- 
2.37.2

