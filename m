Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBF5528FD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 03:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiFUB3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 21:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiFUB3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 21:29:38 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C7192A8
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655774974; bh=dwyMVXk+e04O94590sFMKPbc0JSg8rdaOTpRcscfyN8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=V2WGYlAjj7ap7H98gP8zWQF2uSWwTxyODz0j06mvlp+Ntnv+gaTvbzQZzdhEzBAoAaCqqUePGgUwG4QKwgu2mRW0JN9WbHubpiy/UC3z6TM/HYG2Yg98zOsHF2HCR9uJ4mUPdwfWM79/xyKKxD4aX3hg12GEcaPFa2M9sxZnMuRhpxDeALROpa5drg/9ZeunFuW3Ncof5/oz/PxR01JcwElSlVXFiRVizjax0kTJa3UHYku5FKatzZXUzrHxSaeSw8QszvkVfULxW1HYiY26qvAt6EK8qWkZlGOz+BLuQJHOHBs+nrFstAU/kDlN1QIOgP00glM6rJa8ua2og7e/lQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655774974; bh=WZXMrF+aLejY4RdAmdc5Tv5QMofADqGHoCO5FEJ0RDJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HTZxxLkEwK2bA+fk/qLn6+vB6Y1ENoPYM3dIWyEkGAn/FFkXWV1cLAjM5xNYiRHbhaQdBhaoxF7H35VKSTZhQGp43H8XpkIru1+swYLVDOBPxE8PnKpdxSWBZmkbLZbAYOoggfRstBSKxz7YVpV4Yc96OOZlI6/YXN1IdQ7M46gcYN+xomiMkFuu9hLLu7/p5A1DONwvKNRJ/LxJt6QUrICRoWpbKyBGerzbjesqlB/5GBpcTIu8Zd+DZF/F/JIZfXJpNaBbS5Q7Lu80KwCqLGoQKu1kuvELNRt8s0thCdsv4cJWGfAwHvVaCRPxcwLrT+imaY9IYrBbgjZixlOmPw==
X-YMail-OSG: icQP.aQVM1nI3DGpoBIsALPeQk_eDspb4hQ8Eu3eiVcXQhRCb4sLiI0B7CZBGdc
 Q20TVaGfP05bxAQYr4NjIadJociS4zcmnmtkbVl78HGsgOAEtsnOY3A.6I8glYvuq9WkEV.LSxO1
 idsuHd0i2Yrzi.vzqvb8bg7G_m3gkHQMc7AbFLQVUQofi.v7NpgJuVf2M3lqmncZNOkkq7PAn88p
 ae5gyW12wDr3fyHtdDrrQAnpdv31l8PL_tn__DaY_43EjcrOAXTG9cwnZ1ZVsdCSlQ3xvvGCyFBl
 DhzNsIEWG7DtL.HB1RokMU8o6j3FZXGV6BywKlBUL87qeOeub9D83RR4S2Lc0LuqfwsSzocfUfW0
 GPl3S1wh99_VxG.RLs_w.w5ZXPoXkvd3BYIqyTWDzckJn0gk0HbU068MpWZPQp1SU4Mp8Gj1He2b
 mUjt4QuZc3OJJvN18pKa5.UPs5yINRLyJ0xwPluJ753SBlP5qAEEG3ODqp7PEm7JFwwvKMUCrQNL
 5eo6KvPdb5wY2hxiGvZKEHU1q_fGiUTEz6gcMwDEy.bbUZajmZdTRBK7XlEGTkFN3ViXfqH.8m2f
 34iW_pEevXtMBIcWs21TZ0N2FYfDf0b9ele6Y0WW6MrWGSEshK6WEuWYNZseYmy3GLYkefQ58eZY
 S1blXCwkDVuye9Pkd15FrdMqvt0w5Ovv4WlPkBw2t162xYOMEbABWrL5Xe1B8RE_DmAks3b103s9
 UjKCiMJNJnjvnnSS4I.HGCbqvWFLy8kbkjrru9n_D8TxWxbe1iz9Ir3hernsF_qXZjFdEPynsuWi
 3dP5JPbcaaCvrkeoyNyd_7H5X1.PPNQIccUnRheDkBK4WlyqUzWn39l9j.1tQiPBLHJ06e073Yj1
 HccVOxHzaW7f1e3TPkWwNzpZHlPBlzUML2me_Bwrkv2c3lEHCq.LggDUxIZbUvbtKGkbgpsV.OgX
 zhKEZi.lOpTjAS8gdGirOU3qTsKaUbTbu3lsQk9SEFAUUjj.VBkCYv1wC77HRTpkDefO.hHEY965
 HxQxT0LGNOWo62D5IQWifoMuOWjxiuHvLAWIEugwdPLgRKHaLoBPutB.ZxNotWxzYphzrLjo5IQQ
 c6MPipHrqdsDbTBJOPi9I37Jut1zCHYT2.8XUdDEN1WuQ7ChIviaJb_ZiN0_Ml15OxxBQEBJDki7
 7osYNlh8MAbMv9eQSSDhnvgSAPF14bIRkOQghGXyEn1rOSF4c0oW6balv3O39dGUa8Vv7mRTi7Af
 KxL5PCrOWBqZfV5fs7kaSA_Is3rpNDBTB3Txd0lAretN.eV1G8w7bYxF1OfKmzngGTxgqoasRyrk
 FIEZ9jLfe57PWlj60eQmHVDBr3ei_ldkS.KY7Wk1opU6gsIQZGxCS7JYWHviJtudrFwn_PhTGlpG
 cZovGfDCxx85xfkcAOgR86X3zdskLHCfzF_i5Y3Y13xZXVEOrYPUmazPkAReKalLLjRTlB1zYthd
 Qt.nh3YRGbQalMUB5M2Sibo_3aqdCA0ZHtTTkRUqh0MQl0l1MvQRVZ5NmucC6NK2ZD5O.m.js6JO
 Bu35AXU7sCpZB7lyJ_hBD4fQa1KOro6Zy8n_yT1bNglHK1nyzqT_Vw788YWaZmK6GqMSzGDlL4QG
 hig4BlHKqWiAgjO.fHb78ogihRdOpZONa.VjawBoSMmvWlerP5tSYKZM8HDFiKt3mb8uOXpe7DKd
 P2oypOJTuvt18Fee9lNRBCyihvIZdXgjncdeaQZMNmYWXEKnTGBlzsp93KqF7ujeKWbN9QmvDPZF
 NFbgn4U2VEDmWeGrPumXL9vqGm.jSDLUbgYUpixj7yr2FIA5HwTw_pYmv1b2FNkYAg7U2c6HM9.S
 Qj_4hcSlF238.jE0X8MVuqH5R.qkNKqLi1J55GWGyYj8_N.2nyOL49TOwX1WV3Fus50hcQAC2dGk
 iz1SZ5VTU2PuvQgzY1II1YvrlalWAgbcdbTwx5VV_zxKb_s112PEepl4aiE5j1xaONDbJ3jqh6fi
 n2wemhzxNPhmp8bMV7cPNjwQKV5VHKx4J0F5g8UprEVObsaHe1qLZRsYc9XzoopmRbMQHOeW1ud8
 m22IYPslqt0QvhcqVtbuNKXA6j2QDRVaJ0cU_tigekyIxtmTN8xGcvPeuRBVL6ezsWwYf5cLsp0O
 vdB.5p4wGoBMogNfNevYArfveqNQkCCzCOfRFGpfDGxiKj4HovTgZ3YJx_I_kfLR6jGv4ouROBiP
 94BnzmSBH0nfPOPSLBV9Uo5DORHm4q6LS_5NKC63zVq80eKwzEIPZPOiR4ScpwQG9iIoynNjA1dp
 1jHI-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 01:29:34 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-brwkd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7e24d179eaaa6728f4ead13f3863acec;
          Tue, 21 Jun 2022 01:29:33 +0000 (UTC)
Message-ID: <d51884a5-e3a9-39b9-14dc-5f002982ed6d@rocketmail.com>
Date:   Tue, 21 Jun 2022 03:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
 <20220618162833.218dbe67@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618162833.218dbe67@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18.06.22 17:28, Jonathan Cameron wrote:
>
> On Sat, 18 Jun 2022 02:13:16 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
...
>> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
>> index 07eb619bcfe8..868128cee835 100644
>> --- a/drivers/iio/magnetometer/Kconfig
>> +++ b/drivers/iio/magnetometer/Kconfig
>> @@ -216,8 +216,8 @@ config YAMAHA_YAS530
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say Y here to add support for the Yamaha YAS530 series of
>> -	  3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
>> -	  fully supported.
>> +	  3-Axis Magnetometers. Right now YAS530, YAS532, YAS533 and
>> +	  YAS537 are fully supported.
> Whilst here I'd reduce this to
> 
> 	  3-Axis Magnetometers. YAS530, YAS532, YAS533 and YAS537
> 	  are supported.
> 
> "Right now" provides no information - we are hardly likely to be talking
> about code at some stage in the past or future.
> "fully" isn't all that well defined and doesn't add anything over supported.

OK, will change that.

...

>>  static int yas5xx_read_raw(struct iio_dev *indio_dev,
>>  			   struct iio_chan_spec const *chan,
>>  			   int *val, int *val2,
>> @@ -450,7 +602,18 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>>  	case IIO_CHAN_INFO_PROCESSED:
>>  	case IIO_CHAN_INFO_RAW:
>>  		pm_runtime_get_sync(yas5xx->dev);
>> -		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
>> +		switch (yas5xx->devid) {
>> +		case YAS530_DEVICE_ID:
>> +		case YAS532_DEVICE_ID:
>> +			ret = yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
> 
> As below, use function pointers in a chip_info struct to avoid switch
> statements like this and give shorter + more readable code.

I'll try to implement this.

...

>> +static int yas537_get_calibration_data(struct yas5xx *yas5xx)
>> +{
>> +	struct yas5xx_calibration *c = &yas5xx->calibration;
>> +	u8 data[17];
>> +	u32 val1, val2, val3, val4;
>> +	int i, ret;
>> +
>> +	/* Writing SRST register, the exact meaning is unknown */
>> +	ret = regmap_write(yas5xx->map, YAS537_SRST, BIT(1));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Calibration readout, YAS537 needs one readout only */
>> +	ret = regmap_bulk_read(yas5xx->map, YAS537_CAL, data, sizeof(data));
>> +	if (ret)
>> +		return ret;
>> +	dev_dbg(yas5xx->dev, "calibration data: %17ph\n", data);
>> +
>> +	/* Sanity check, is this all zeroes? */
>> +	if (!memchr_inv(data, 0x00, 16)) {
>> +		if (FIELD_GET(GENMASK(5, 0), data[16]) == 0)
>> +			dev_warn(yas5xx->dev, "calibration is blank!\n");
>> +	}
>> +
>> +	/* Contribute calibration data to the input pool for kernel entropy */
>> +	add_device_randomness(data, sizeof(data));
>> +
>> +	/* Extract version information */
>> +	yas5xx->version = FIELD_GET(GENMASK(7, 6), data[16]);
>> +
>> +	/* There are two versions of YAS537 behaving differently */
>> +	switch (yas5xx->version) {
>> +
>> +	case YAS537_VERSION_0:
> Seems like we might need more chip_info variants, though perhaps in this case
> it is worth handling it as a switch statement as hopefully the number of
> way s this is done for a given part number won't grow any further.

Yes, I think I'll introduce chip_info for the variants like YAS530,
YAS532, etc. but keep handling the versions (like 0 and 1 in this case)
within the functions. I'll have a look again when preparing patchset v4.

>> +
>> +		/*
>> +		 * The first version simply writes data back into registers:
>> +		 *
>> +		 * data[0]  YAS537_MTC		0x93
>> +		 * data[1]			0x94
>> +		 * data[2]			0x95
>> +		 * data[3]			0x96
>> +		 * data[4]			0x97
>> +		 * data[5]			0x98
>> +		 * data[6]			0x99
>> +		 * data[7]			0x9a
>> +		 * data[8]			0x9b
>> +		 * data[9]			0x9c
>> +		 * data[10]			0x9d
>> +		 * data[11] YAS537_OC		0x9e
>> +		 *
>> +		 * data[12] YAS537_OFFSET_X	0x84
>> +		 * data[13] YAS537_OFFSET_Y1	0x85
>> +		 * data[14] YAS537_OFFSET_Y2	0x86
>> +		 *
>> +		 * data[15] YAS537_HCK		0x88
>> +		 * data[16] YAS537_LCK		0x89
>> +		 */
>> +
>> +		for (i = 0; i < 17; i++) {
> 
> Reduce indent by doing this as multiple loops.
> Though even better if you can use bulk writes.
> 
> 		int j = 0;
> 		for (i = 0; i < 12; i++) {
> 			ret = regmap_write(yas5xx->map, YAS537_MTC + i,
> 					   data[j++])
> 			if (ret)
> 				return ret;
> 		}
> 
> 		for (i = 0; i < 4; i++) {
> 			ret = regmap_write(yas5xx->map, YAS573_OFFSET_X + i,
> 					   data[j++]);
> 			if (ret)
> 				return ret;
> 		} 	

I'll change that.

It would also work without adding "int j = 0;" when using data[i + 12]
in the second loop. But I guess you added integer j on purpose, I'll
apply it.

>> +			if (i < 12) {
>> +				ret = regmap_write(yas5xx->map,
>> +						   YAS537_MTC + i,
>> +						   data[i]);
>> +				if (ret)
>> +					return ret;
>> +			} else if (i < 15) {
>> +				ret = regmap_write(yas5xx->map,
>> +						   YAS537_OFFSET_X + i - 12,
>> +						   data[i]);
>> +				if (ret)
>> +					return ret;
>> +				yas5xx->hard_offsets[i - 12] = data[i];
>> +			} else {
>> +				ret = regmap_write(yas5xx->map,
>> +						   YAS537_HCK + i - 15,
>> +						   data[i]);
>> +				if (ret)
>> +					return ret;
>> +			}
>> +		}
>> +
>> +		break;
>> +
>> +	case YAS537_VERSION_1:
>> +
>> +		/*
>> +		 * The second version writes some data into registers but also
>> +		 * extracts calibration coefficients.
>> +		 *
>> +		 * Registers being written:
>> +		 *
>> +		 * data[0]  YAS537_MTC			0x93
>> +		 * data[1]  YAS537_MTC+1		0x94
>> +		 * data[2]  YAS537_MTC+2		0x95
>> +		 * data[3]  YAS537_MTC+3 (partially)	0x96
>> +		 *
>> +		 * data[12] YAS537_OFFSET_X		0x84
>> +		 * data[13] YAS537_OFFSET_Y1		0x85
>> +		 * data[14] YAS537_OFFSET_Y2		0x86
>> +		 *
>> +		 * data[15] YAS537_HCK (partially)	0x88
>> +		 *          YAS537_LCK (partially)	0x89
>> +		 * data[16] YAS537_OC  (partially)	0x9e
>> +		 */
>> +
>> +		for (i = 0; i < 3; i++) {
>> +			ret = regmap_write(yas5xx->map, YAS537_MTC + i,
>> +					   data[i]);
>> +			if (ret)
>> +				return ret;
>> +			ret = regmap_write(yas5xx->map, YAS537_OFFSET_X + i,
>> +					   data[i + 12]);
>> +			if (ret)
>> +				return ret;
>> +			yas5xx->hard_offsets[i] = data[i + 12];
>> +		}
>> +
>> +		/*
>> +		 * Visualization of partially taken data:
>> +		 *
>> +		 * data[3]       n 7 6 5 4 3 2 1 0
>> +		 * YAS537_MTC+3    x x x 1 0 0 0 0
>> +		 *
>> +		 * data[15]      n 7 6 5 4 3 2 1 0
>> +		 * YAS537_HCK      x x x x 0
>> +		 *
>> +		 * data[15]      n 7 6 5 4 3 2 1 0
>> +		 * YAS537_LCK              x x x x 0
>> +		 *
>> +		 * data[16]      n 7 6 5 4 3 2 1 0
>> +		 * YAS537_OC           x x x x x x
>> +		 */
>> +
>> +		ret = regmap_write(yas5xx->map, YAS537_MTC + 3,
>> +				   (data[3] & GENMASK(7, 5)) | BIT(4));
> 
> If we can give the masks meaningful names that would be great then
> use FIELD_GET and FIELD_PREP with those defines (even if it puts it back
> in the same place like here).  Let the compiler optimise out anything
> unnecessary in the way of masks and shifts.

I don't know what these abbreviations stand for. We could do:

#define YAS537_MTC3_MASK_PREP ...
#define YAS537_MTC3_MASK_GET ...
#define YAS537_HCK_MASK_PREP ...
#define YAS537_HCK_MASK_GET ...
etc.

We need both FIELD_GET and FIELD_PREP, right? The first to retrieve the
data and the second to place it at the right position.

Doesn't that get strange-looking like:

        ret = regmap_write(yas5xx->map, YAS537_HCK,
                           FIELD_PREP(YAS537_HCK_MASK_PREP,
                                      FIELD_GET(YAS537_HCK_MASK_GET,
                                                data[15])));

Or maybe different indentation, would that be acceptable?

        ret = regmap_write(yas5xx->map, YAS537_HCK,
                           FIELD_PREP(YAS537_HCK_MASK_PREP,
                           FIELD_GET(YAS537_HCK_MASK_GET, data[15])));

On the one above your comment, the "YAS537_MTC + 3", we would still need
the "| BIT(4)" to place that "1" there. Or is there some other trick to
do this?

>> +		if (ret)
>> +			return ret;
>> +		ret = regmap_write(yas5xx->map, YAS537_HCK,
>> +				   FIELD_GET(GENMASK(7, 4), data[15]) << 1);
> 
> FIELD_PREP() with suitable mask defined to make it clear what field is being written.
> 
>> +		if (ret)
>> +			return ret;
>> +		ret = regmap_write(yas5xx->map, YAS537_LCK,
>> +				   FIELD_GET(GENMASK(3, 0), data[15]) << 1);
>> +		if (ret)
>> +			return ret;
>> +		ret = regmap_write(yas5xx->map, YAS537_OC,
>> +				   FIELD_GET(GENMASK(5, 0), data[16]));
>> +		if (ret)
>> +			return ret;
>> +

...

>> @@ -946,35 +1415,53 @@ static int yas5xx_probe(struct i2c_client *i2c,
>>  
> 
> Below becomes something like
> 	ret = yas5xx->chip_info.get_calib_data(yas5xx);
> 	if (ret)
> 		goto assert_reset;
> 
> 	yas5xx->chip_info.dump_calibration(yas5xx);
> 	yas5xx->chip_info.power_on(yas5xx)
> 	if (yas5xx->chip_info.measure_offsets) {
> 		ret = yas5xx->chip_info.measure_offsets(yas5xx);
> 		if (ret)
> 			got asert_reset;
> 	}
> 	Which is a lot more readable and less code at the expense
> 	of static const data (a good trade off in most cases).

Thanks for the example, that's helpful.

If YAS537 doesn't have a .measure_offsets function pointer in chip_info,
it skips that if statement cleanly?

...

Kind regards,
Jakob
