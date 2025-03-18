Return-Path: <linux-iio+bounces-17024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B2A6767D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E3E3A8A09
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83620DD7B;
	Tue, 18 Mar 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="WfbsVO0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01072302.me.com (qs51p00im-qukt01072302.me.com [17.57.155.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51621F8726
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308538; cv=none; b=Zyfi4TikGVNUCZUYApSQAGCn6ou+IZ4MJekprQG9vMKT5pk+71m4pSYCTfYuZZjaOhYRDc2YF9b6K7LnYbQMNJ4v7XK8vF5wLFSclprcxdPzw8bf8gt4oTmuHcO9qGsocbmhUx4bsPdj3LCo2CeeQwubN0kocRi4b852+s3U2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308538; c=relaxed/simple;
	bh=ORmbWsnXdcFFbg0ZJfy6uldd0BNfUSX/y9lFdDQgEsw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Y60u9CtkixknMtpOgaK/450LcfovShWwf+Rt7adehr5EkZUUfYz8GrrEKAXog59hhFGzS9QSN+SRyNx7tZdruZnAYWiwpHLxJem6GvGaHsMIZSuTxXV4DU4g3PPu4lmRgU4OrS3im2BR3t9soKsnyk9uDrUNcmWaItZnHcWumec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=WfbsVO0Q; arc=none smtp.client-ip=17.57.155.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=ZmcwMguPH4y+IVnuEBHU0TSD3b+I1p4u7OE1JZlrnN0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From:x-icloud-hme;
	b=WfbsVO0QZ1BYmCAQbU8cfwFIMWah3YZq3saJy43MQl4OEgTtNBBY87EMng8StFkK9
	 TSZFh8WvjrUE05GejVShzsPLyXN193hgOzaTe6OXjyK83ITk1wjzyN7/uZuVXG0UE7
	 pDld0zgSi/ldZAyEI/jjHo/MlezHp1IzDuM4N58eko1KT4J29uEDi4uSlWMypSPzV6
	 +faOtDb0POLEVNFXX1PGDPu375dBsxo9HYamwVyL4cwqhnrHVQ6U0jSq3Sl8LgYRj4
	 CqXxkwDHa7lBcAsCldc5cAlP79aiOcb5afCfm/RpJuTq2LDnNaFpLp6CytXakhPwU9
	 FlWAYXUsftIWw==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072302.me.com (Postfix) with ESMTPSA id F18D6630018D;
	Tue, 18 Mar 2025 14:35:31 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------9091b8IxBPgvEeVGZo8prD8m"
Message-ID: <a1ee42f8-56c8-4a77-ab94-e0bb88476cbf@pereznus.es>
Date: Tue, 18 Mar 2025 15:35:29 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: tduszyns@gmail.com, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <20250317115815.2416c741@jic23-huawei>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <20250317115815.2416c741@jic23-huawei>
X-Proofpoint-ORIG-GUID: btg1TpWSOUaj4Hkl_tclZGQ-mR38R8Wq
X-Proofpoint-GUID: btg1TpWSOUaj4Hkl_tclZGQ-mR38R8Wq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1030 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503180107

This is a multi-part message in MIME format.
--------------9091b8IxBPgvEeVGZo8prD8m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


El 17/03/2025 a las 12:58, Jonathan Cameron escribió:
> On Sun, 16 Mar 2025 15:55:13 +0100
> Sergio Perez <sergio@pereznus.es> wrote:
>
>> Some BH1750 sensors require a hardware reset before they can be
>> detected on the I2C bus. This patch adds support for an optional
>> reset GPIO that can be specified in the device tree.
>>
>> The reset sequence pulls the GPIO low and then high before
>> initializing the sensor, which enables proper detection with
>> tools like i2cdetect.
>>
>> Update the devicetree binding documentation to include the new
>> reset-gpios property with examples.
>>
>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>> ---
>>   .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
>>   drivers/iio/light/bh1750.c                    | 113 ++++++++++++------
>>   2 files changed, 95 insertions(+), 38 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> index 1a88b3c253d5..d53b221eb84b 100644
>> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> @@ -11,6 +11,9 @@ maintainers:
>>   
>>   description: |
>>     Ambient light sensor with an i2c interface.
>> +
>> +  Some BH1750 sensors require a hardware reset before being properly detected
>> +  on the I2C bus. This can be done using the optional reset-gpios property.
> I don't think this detail belongs here. In general we are going to reset
> them all if we have the GPIO.
>
>>   
>>   properties:
>>     compatible:
>> @@ -23,6 +26,10 @@ properties:
>>   
>>     reg:
>>       maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: GPIO connected to the sensor's reset line (active low)
>> +    maxItems: 1
>>   
>>   required:
>>     - compatible
>> @@ -41,5 +48,16 @@ examples:
>>           reg = <0x23>;
>>         };
>>       };
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      light-sensor@23 {
>> +        compatible = "rohm,bh1750";
>> +        reg = <0x23>;
>> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> Add the GPIO to the existing example rather than having a new one.

Yes, I am going to change it.

>> +      };
>> +    };
>>   
>> -...
>> +...
>> \ No newline at end of file
>> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
>> index 4b869fa9e5b1..53d64b70c03f 100644
>> --- a/drivers/iio/light/bh1750.c
>> +++ b/drivers/iio/light/bh1750.c
>> @@ -22,11 +22,16 @@
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>>   #include <linux/module.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/of.h>
> As already pointed out, there is a lot of accidental stuff in here.
>
> I'll review again once that is sorted out. For now I'll ignore it.
> If I weren't on a train and bored, I'd probably just have waited for v2.
>
>
>>   
>> -#define BH1750_POWER_DOWN		0x00
>> -#define BH1750_ONE_TIME_H_RES_MODE	0x20 /* auto-mode for BH1721 */
>> -#define BH1750_CHANGE_INT_TIME_H_BIT	0x40
>> -#define BH1750_CHANGE_INT_TIME_L_BIT	0x60
>> +#define BH1750_POWER_DOWN 0x00
>> +#define BH1750_ONE_TIME_H_RES_MODE 0x20 /* auto-mode for BH1721 */
>> +#define BH1750_CHANGE_INT_TIME_H_BIT 0x40
>> +#define BH1750_CHANGE_INT_TIME_L_BIT 0x60
>> +
>> +/* Define the reset delay time in microseconds */
>> +#define BH1750_RESET_DELAY_US 10000  /* 10ms */
>>   
>>   enum {
>>   	BH1710,
>> @@ -40,6 +45,7 @@ struct bh1750_data {
>>   	struct mutex lock;
>>   	const struct bh1750_chip_info *chip_info;
>>   	u16 mtreg;
>> +	struct gpio_desc *reset_gpio;
>>   };
>>   
>>   struct bh1750_chip_info {
>> @@ -62,11 +68,26 @@ struct bh1750_chip_info {
>>   
>> +static int bh1750_reset(struct bh1750_data *data)
>> +{
>> +	if (!data->reset_gpio)
> No need to check outside and in here.
>
>> +		return 0;  /* No GPIO configured for reset, continue */
>> +
>> +	/* Perform reset sequence: low-high */
>> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
>> +	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);
> fsleep for cases like this where is approximately but greater than X usecs.
>
>> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
>> +	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);
> fsleep
>> +
>> +	dev_info(&data->client->dev, "BH1750 reset completed via GPIO\n");
> Too noisy. dev_dbg at most for something like this.
>
>> +	return 0;
>> +}
>
>> @@ -248,6 +266,19 @@ static int bh1750_probe(struct i2c_client *client)
>>   	data->client = client;
>>   	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
>>   
>> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(data->reset_gpio)) {
>> +		ret = PTR_ERR(data->reset_gpio);
>> +		dev_err(&client->dev, "Failed to get reset GPIO: %d\n", ret);
>> +		return ret;
> Use return dev_err_probe().  In general good to have because of pretty printing
> errors messages etc, but in this case you might get a deferral request and
> that call adds a bunch of debug info for probe deferal.
>
>> +	}
>> +
>> +	if (data->reset_gpio) {
>> +		ret = bh1750_reset(data);
> There isn't a lot going on in that function, so I'd pull all the code down
> here and not bother with a function at all.
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +

Thanks for the suggestions, I rewrote the code with all these points, I 
passed the tests again and everything seems correct.


--------------9091b8IxBPgvEeVGZo8prD8m
Content-Type: text/plain; charset=UTF-8;
 name="0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch"
Content-Disposition: attachment;
 filename*0="0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyNDkzYjYwYjkyNGZhZDc4NzA5OGFiMmUzZjFiOWJhOWE5YTY0OWMxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gUGVyZXogPHNlcmdpb0BwZXJlem51cy5l
cz4KRGF0ZTogVHVlLCAxOCBNYXIgMjAyNSAwMToxMjowNSArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGlpbzogbGlnaHQ6IGJoMTc1MDogQWRkIGhhcmR3YXJlIHJlc2V0IHN1cHBvcnQgdmlh
IEdQSU8KClNvbWUgQkgxNzUwIHNlbnNvcnMgcmVxdWlyZSBhIGhhcmR3YXJlIHJlc2V0IGJl
Zm9yZSB0aGV5IGNhbiBiZQpkZXRlY3RlZCBvbiB0aGUgSTJDIGJ1cy4gVGhpcyBwYXRjaCBh
ZGRzIHN1cHBvcnQgZm9yIGFuIG9wdGlvbmFsCnJlc2V0IEdQSU8gdGhhdCBjYW4gYmUgc3Bl
Y2lmaWVkIGluIHRoZSBkZXZpY2UgdHJlZS4KClRoZSByZXNldCBzZXF1ZW5jZSBwdWxscyB0
aGUgR1BJTyBsb3cgYW5kIHRoZW4gaGlnaCBiZWZvcmUKaW5pdGlhbGl6aW5nIHRoZSBzZW5z
b3IsIHdoaWNoIGVuYWJsZXMgcHJvcGVyIGRldGVjdGlvbiB3aXRoCnRvb2xzIGxpa2UgaTJj
ZGV0ZWN0LgoKVXBkYXRlIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB0
byBpbmNsdWRlIHRoZSBuZXcKcmVzZXQtZ3Bpb3MgcHJvcGVydHkgd2l0aCBleGFtcGxlcy4K
ClNpZ25lZC1vZmYtYnk6IFNlcmdpbyBQZXJleiA8c2VyZ2lvQHBlcmV6bnVzLmVzPgotLS0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdodC9iaDE3NTAueWFtbCB8ICA1ICsr
KysrCiBkcml2ZXJzL2lpby9saWdodC9iaDE3NTAuYyAgICAgICAgICAgICAgICAgICAgfCAy
MiArKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlv
L2xpZ2h0L2JoMTc1MC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9saWdodC9iaDE3NTAueWFtbAppbmRleCAxYTg4YjNjMjUzZDUuLmY3YThkY2Q3ZDJh
MSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9s
aWdodC9iaDE3NTAueWFtbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2xpZ2h0L2JoMTc1MC55YW1sCkBAIC0yNCw2ICsyNCwxMCBAQCBwcm9wZXJ0aWVz
OgogICByZWc6CiAgICAgbWF4SXRlbXM6IDEKIAorICByZXNldC1ncGlvczoKKyAgICBkZXNj
cmlwdGlvbjogR1BJTyBjb25uZWN0ZWQgdG8gdGhlIHNlbnNvcidzIHJlc2V0IGxpbmUgKGFj
dGl2ZSBsb3cpCisgICAgbWF4SXRlbXM6IDEKKwogcmVxdWlyZWQ6CiAgIC0gY29tcGF0aWJs
ZQogICAtIHJlZwpAQCAtMzksNiArNDMsNyBAQCBleGFtcGxlczoKICAgICAgIGxpZ2h0LXNl
bnNvckAyMyB7CiAgICAgICAgIGNvbXBhdGlibGUgPSAicm9obSxiaDE3NTAiOwogICAgICAg
ICByZWcgPSA8MHgyMz47CisgICAgICAgIHJlc2V0LWdwaW9zID0gPCZncGlvMiAxNyAwPjsK
ICAgICAgIH07CiAgICAgfTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvYmgx
NzUwLmMgYi9kcml2ZXJzL2lpby9saWdodC9iaDE3NTAuYwppbmRleCA0Yjg2OWZhOWU1YjEu
LmI4OGNlOTJhY2JjNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vbGlnaHQvYmgxNzUwLmMK
KysrIGIvZHJpdmVycy9paW8vbGlnaHQvYmgxNzUwLmMKQEAgLTIyLDEyICsyMiwxNiBAQAog
I2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4KICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMu
aD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9ncGlvL2Nv
bnN1bWVyLmg+CiAKICNkZWZpbmUgQkgxNzUwX1BPV0VSX0RPV04JCTB4MDAKICNkZWZpbmUg
QkgxNzUwX09ORV9USU1FX0hfUkVTX01PREUJMHgyMCAvKiBhdXRvLW1vZGUgZm9yIEJIMTcy
MSAqLwogI2RlZmluZSBCSDE3NTBfQ0hBTkdFX0lOVF9USU1FX0hfQklUCTB4NDAKICNkZWZp
bmUgQkgxNzUwX0NIQU5HRV9JTlRfVElNRV9MX0JJVAkweDYwCiAKKy8qIERlZmluZSB0aGUg
cmVzZXQgZGVsYXkgdGltZSBpbiBtaWNyb3NlY29uZHMgKi8KKyNkZWZpbmUgQkgxNzUwX1JF
U0VUX0RFTEFZX1VTIDEwMDAwIC8qIDEwbXMgKi8KKwogZW51bSB7CiAJQkgxNzEwLAogCUJI
MTcyMSwKQEAgLTQwLDYgKzQ0LDcgQEAgc3RydWN0IGJoMTc1MF9kYXRhIHsKIAlzdHJ1Y3Qg
bXV0ZXggbG9jazsKIAljb25zdCBzdHJ1Y3QgYmgxNzUwX2NoaXBfaW5mbyAqY2hpcF9pbmZv
OwogCXUxNiBtdHJlZzsKKwlzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvOwogfTsKIAog
c3RydWN0IGJoMTc1MF9jaGlwX2luZm8gewpAQCAtMjQ4LDYgKzI1MywyMyBAQCBzdGF0aWMg
aW50IGJoMTc1MF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogCWRhdGEtPmNs
aWVudCA9IGNsaWVudDsKIAlkYXRhLT5jaGlwX2luZm8gPSAmYmgxNzUwX2NoaXBfaW5mb190
YmxbaWQtPmRyaXZlcl9kYXRhXTsKIAorCS8qIEdldCByZXNldCBHUElPIGZyb20gZGV2aWNl
IHRyZWUgKi8KKwlkYXRhLT5yZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwo
JmNsaWVudC0+ZGV2LCAicmVzZXQiLCBHUElPRF9PVVRfSElHSCk7CisJaWYgKElTX0VSUihk
YXRhLT5yZXNldF9ncGlvKSkKKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJmNsaWVudC0+ZGV2
LCBQVFJfRVJSKGRhdGEtPnJlc2V0X2dwaW8pLAorCQkJCQkJCSJGYWlsZWQgdG8gZ2V0IHJl
c2V0IEdQSU9cbiIpOworCisJLyogUGVyZm9ybSBoYXJkd2FyZSByZXNldCBpZiBHUElPIGlz
IHByb3ZpZGVkICovCisJaWYgKGRhdGEtPnJlc2V0X2dwaW8pIHsKKwkJLyogUGVyZm9ybSBy
ZXNldCBzZXF1ZW5jZTogbG93LWhpZ2ggKi8KKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVw
KGRhdGEtPnJlc2V0X2dwaW8sIDApOworCQlmc2xlZXAoQkgxNzUwX1JFU0VUX0RFTEFZX1VT
KTsKKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGRhdGEtPnJlc2V0X2dwaW8sIDEpOwor
CQlmc2xlZXAoQkgxNzUwX1JFU0VUX0RFTEFZX1VTKTsKKworCQlkZXZfZGJnKCZjbGllbnQt
PmRldiwgIkJIMTc1MCByZXNldCBjb21wbGV0ZWQgdmlhIEdQSU9cbiIpOworCX0KKwogCXVz
ZWMgPSBkYXRhLT5jaGlwX2luZm8tPm10cmVnX3RvX3VzZWMgKiBkYXRhLT5jaGlwX2luZm8t
Pm10cmVnX2RlZmF1bHQ7CiAJcmV0ID0gYmgxNzUwX2NoYW5nZV9pbnRfdGltZShkYXRhLCB1
c2VjKTsKIAlpZiAocmV0IDwgMCkKLS0gCjIuNDMuMAoK

--------------9091b8IxBPgvEeVGZo8prD8m--

