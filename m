Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF036F7E1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhD3J0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 05:26:42 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:15968
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhD3J0m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Apr 2021 05:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4K/oCF1WrbW9ELjtc2AIpDarTRbL7C2Sz88P3YRGOdM4stXOel4llRWCWuvgoEiJL6vvDZOOztIM15KePpk00g53LKJsM5D308IEf8SHBTD63fVVzbgcuCKvJGpLDi2RcJXpRQ4IGP2cQQ0aGJx0pEVAsM780mb5uHOUMIw8yptAnHMIYPNUaBBFoygFO72UQL6uutcrGG+XbI25aP00fJIfqUsSrENIAzKrkf8vWSly3/0uJR3tQr1Ktvy/zQT8phZaX4kZdTClPQK4Z4R0PULbQQzbNux+G5h4+mLzcOsazqHI0X5NgWCCs0/ZZoa9/tY0cfb1CWZFX0MIM23Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXfjRXtORUjx1fN4U9EkAlySCTp8l97GGMBKi6gobMU=;
 b=lpqeYjcEowt6usHvEvomE/D2lVf8IMZE82dHxheeqMTjhjoi827zCH+OblQO9tw0W8wKquAW3PPxgLyTUYAURDowpJ2WiO1uXpZPk4nNtFLejqZJxpk2mt9oaV+/AehHrij2LzOeSGSR/7sj7Z3U841HwNomZ2hq3hGhmUuPoPiVep6RjG4wzXduC49/MoVi2xdWT2CtbnYcK9idBaRMaw6IVfI26erjmNrh4pREfBREPzKTcNOf0Su3/24qGjZqQvmrpH2EylWJK4eIDnaG3N60yCGKEN7PbiwD1TdkokI7VjNFNvyCjDBb+A78Y4n+VWw7QXhCpUiVT2olHFRpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXfjRXtORUjx1fN4U9EkAlySCTp8l97GGMBKi6gobMU=;
 b=ZNeJaKeoKI5DmSGsFR1jYIkH0QK54rw2R+G+jMsYwAMJniy2CQfJkvjDNtxnTg6TMX5HAF627IOqxlCYfGMiDuowCsWKun8/FKHz5aUt5X4fvOOVW+C2YQaHGgwEKpdGS0BiO5OA1pIT0oP89bdMThUyDmqiw49p00Rwep8x/HrI5HWHM7799aF19RZmbKk3j61ElyrlyZ6kVYnelOfAp675XBzImMm/ylSO6P7m6fpipOyC2Yf3BbVDlBZ++Gm8TBlTJZsQRGsOZDhYuqbIq1NCez9jc2XwtBPIOB2JCXLotgyXafeVKYckuYcRAoY/2l01LCvKEx65IXpakhEfGQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB3085.eurprd06.prod.outlook.com
 (2603:10a6:802:b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 09:25:52 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 09:25:52 +0000
Subject: Re: [PATCH v4 1/6] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Nuno.Sa@analog.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20210429122806.3814330-1-sean@geanix.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <ab6fffc8-2e40-47b4-24f2-6ec5b7803915@vaisala.com>
Date:   Fri, 30 Apr 2021 12:25:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20210429122806.3814330-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0402CA0025.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::14) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.137] (85.156.166.106) by HE1PR0402CA0025.eurprd04.prod.outlook.com (2603:10a6:7:7c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 09:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b0e504-9fa8-4277-4dae-08d90bb9f2c6
X-MS-TrafficTypeDiagnostic: VI1PR06MB3085:
X-Microsoft-Antispam-PRVS: <VI1PR06MB30856CA1E7DCA93BE457001EFD5E9@VI1PR06MB3085.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YroJ+90onxghXX6E43vlujrgodFWkknPPgOrVQSOVFGE+AjSkljF6dcNLUtXaCENg7PT5Gkb/ZbDiVkv0vSaLEc2XGEshHbF1ZbIDag1+tzjJMpiFxvDtFpmau3hDj1RTtGUf3FOkzjFYeyz0RLXB3JjGrZsiTssXUUVLRum5gabkVD/+oI9bkRDp56Iw/Qw3vS014ch+Pl383XcaQAHdWJuu5rq91J1DRQDpNs+6WWCYPQrXjddbN9rq5Gr288elVLPLJyp3ZHpu1Bq1tTqQPi1HWBKHhk5acpSGoD901Qiv9Uw8s/eydBjr6CgRe2i+S6E8jvhB+6yl4HA7PPdBOnIJKvORVPjvVEP5u3GeAWsWBTui6CTI+azdimydfz1PDOhk8IK8Ba41y9xXiJFmw//d3s4ItLIYWccVGlGIxonqObZmlnBAhD8AP7Wj+X+5lPsq2FOCvcCmGksovr170DdKThvFZ1g7NlF1YfSbunNCAbIRqI0mRKztNFZVvfKVxmNRZti6TKbZ0/qoEvWPomobWWubtyYCIwJ5ALcjIkUUhEVcEnvRsbhPSyhtXJ/Ldp+ZVMBtmqNsIAK6bCHWfKPYRK6pveFl1CbrdfoGp7tl9C4+ZhWan85nqHYb0QF0hyLS9udJztP6VSl6WArBaVOI1qc8eB2G9ZYwNaCJcN1EcwM9JSPWcRfzvtIRAuHY8eWUEypaGN4iPgwErNgI8RNjkg0Yr/YX++aBxOwWoroj21TsmRpoeLfJhwsyGePZCTN0FXBFH0EZxUzYfaQmbo1hkPwjXoE4MET0TibjtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(478600001)(186003)(2906002)(53546011)(86362001)(966005)(36756003)(52116002)(31686004)(26005)(16576012)(316002)(83380400001)(5660300002)(31696002)(66476007)(8936002)(956004)(6666004)(66556008)(16526019)(8676002)(38100700002)(66946007)(38350700002)(6486002)(44832011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTkzb0p3c3dOOFIxWVdsUjNncWNzM1BpSnlhSnNoUEtTUTlUYjBzczYyZXVj?=
 =?utf-8?B?UlpzbVc3MVJVaDNCYnRiWlhKcGVITjBhWGlBNVJ1eGhoS20zUUhRWXpMeENE?=
 =?utf-8?B?ZEVNbUZaZ1h3L3ExNm4yQ3FOREZ4TEVHVHVhc1JEMDhrL1lBMUJGNmNxN0pU?=
 =?utf-8?B?UmFMeldPdFB1RHRkbEF6ZW11OG55bjV3UEF2cXZYZXBwN0JyY284aXhzZ0hn?=
 =?utf-8?B?L1FKZHQwazJkRnh4cnR0QkNLSks2MlhMRkN3NExqYktMaTFMS0loTFFUMUR3?=
 =?utf-8?B?UTNTbW9jcXorNURoOGF0bW80OS9PWWhRSWdQTXdrWThxQlFsVlRHeFVjN2dL?=
 =?utf-8?B?QnpnZUhSaXkzVHhNeGN6SUQ2b2RuZWh5VXBsdW1jUE9vdFdWczJhOG5kMTl2?=
 =?utf-8?B?UUhiRTY0WU1FRk9ucDVueEdQZ1pnQ3U0T3huMjIybWNRMEE3dWhnUld2b0hL?=
 =?utf-8?B?eGl2eEQzM2JOYmlYeGUzSGJvcGw4V3l6T2MxU1FNOGh2a01qUUZ4UHQyU2NF?=
 =?utf-8?B?aVVTc1BpTVU5dFhDNzdTYmswbWNud1J4MTBIWXd5STdUN2ZnOTlKdnhEUjdW?=
 =?utf-8?B?dnJQTXl4Zy9XbGp2Q3Z3RDRyN2dYWi9VS2xvQUIrb0drdEtaWDZhQVFPbmJD?=
 =?utf-8?B?VlNVNUdxbHRncjJaS2NBZjNnWmthOU90K2JRYjlLRHZ1V2NobFhBMjhtRytF?=
 =?utf-8?B?U2wxNDlNZVpvVEVUNHExcU5RNlR1VlBQTkljWHhTemxVajh6Y3NybGdvbUNH?=
 =?utf-8?B?WEtXb0ZWWGdlMUx6M0t4d1g5QktEWktCZDdCc1FUK3NXMDJxa0xPV3FYZmhl?=
 =?utf-8?B?TUpTVS9vc1gyd05xL3o3dDZFdnZlYlMvVFlQQ1VrZjVlb3dMa01tTGdnMkli?=
 =?utf-8?B?ZlBsbnlpZzFYc1BDb0pBd2V3Z0pBekhCdFBvUDIvWTZjYytmMy92RmJOcnRh?=
 =?utf-8?B?dEk2T0tvZktIbnREREZpMFVvaExkSUt1Mkx3N29XMUZlUXMwWU43VmRuY1hN?=
 =?utf-8?B?NEtBU3pTbmhrUEdoVGYyWGlSQUdpYU04R3BIalJEUkJpWGJYNmZiYnhDZS9j?=
 =?utf-8?B?ckZ4bXZaSDhLVGx2cFFCank0TTg4Uk5GYUREZ1JNL3MySTRNalBBcjlIZGI2?=
 =?utf-8?B?MXl1Q1RZSVhBV3FLMlpWZWo5b09JNkNBSFdaS3B4WTJLTWRQelhWNTA2VHk2?=
 =?utf-8?B?VjJSbGdlNDIycWQ0SGlZckxQbVVObWM4WE1rVHhTMDBERnNLSkNHNWpKcnFp?=
 =?utf-8?B?MUFuQ2VuZ0pIVFNKcmU3YXBiQ0VOK3ZmZzJLaUV3dWNuZ1lOakozbFViZWpj?=
 =?utf-8?B?d2JtdkhYUEJ5L0JpcHlnZWZqYzE3dFFjMmJRbnNlUFdMNWNRNS9ucElaV0JU?=
 =?utf-8?B?VWFBazdJblZ6R2UvMVJBM0xhUXFWd3NUVEpXazBNWTl3d1ZGeFV2UXFqTmI1?=
 =?utf-8?B?ZGFzaTlRaW5DZXIybkUyditqTmdhak05Y3VRYVBxS0c0dUp1Y0JaWVlacEpM?=
 =?utf-8?B?ZXF3a29rUXBIaDNEdnhxV3l2Vk1NNGhWdGh4eHd5UlVIQlBqTEZZa0FNT3hD?=
 =?utf-8?B?ZWkzT1ROZzg3cVM5NitaWG83YjVzOUxaREdFbVZ1TUd6TkErL0tTZ1IxWGFY?=
 =?utf-8?B?S3JLRVlHdjcyL2VyYkplSWZYT3owaThBdlE4anlOWXNZRGxuRytIUHppSHhF?=
 =?utf-8?B?SlExbEVYT09Banl6WXpES0RVd2J6T3Z6Ky81OEdhQWRZSHhHbXEvSGJ1TzJy?=
 =?utf-8?Q?9znqI9TrfEsBSB0LEPBYR/iDIz3BTBL6PJ7zYNi?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0e504-9fa8-4277-4dae-08d90bb9f2c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 09:25:52.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rYac8bHgwXoUyjqXls2CKka+CqEp1tEY8Ixn4iN3vdueAOdPLWQN2WmHY4QMVq26A5780MklC0hZQHpFSTnHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3085
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

few comments inline below.

Thanks,

Tomas


On 4/29/21 3:28 PM, Sean Nyekjaer wrote:
> Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
> accelerometers.
> It will allow setting up scale/gain and reading x,y,z
> axis.
>
> Datasheet: https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
> Datasheet: https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes for v2:
>   - Addressed Kconfig comments
>   - Using regmap_read_poll_timeout()
>   - Addresed comments from Andy and Jonathan
>
> Changes for v3:
>   - fixed Kconfig ordering
>   - read INT_STATUS after reset, to ensure the device is ready
>   - fixed a few xmas trees
>   - added datasheet tags
>
> Changes for v4:
>   - reworked read_raw -> fxls8962af_get_out, so we will skip the claim
>     part.
>   - Removed the drdy check, worstcase data will be 1,28s/0.781Hz old.
>
>   drivers/iio/accel/Kconfig           |  27 ++
>   drivers/iio/accel/Makefile          |   3 +
>   drivers/iio/accel/fxls8962af-core.c | 563 ++++++++++++++++++++++++++++
>   drivers/iio/accel/fxls8962af-i2c.c  |  57 +++
>   drivers/iio/accel/fxls8962af-spi.c  |  57 +++
>   drivers/iio/accel/fxls8962af.h      |  22 ++
>   6 files changed, 729 insertions(+)
>   create mode 100644 drivers/iio/accel/fxls8962af-core.c
>   create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
>   create mode 100644 drivers/iio/accel/fxls8962af-spi.c
>   create mode 100644 drivers/iio/accel/fxls8962af.h
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 2e0c62c39155..7317d839ca1a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -208,6 +208,33 @@ config DMARD10
>   	  Choosing M will build the driver as a module. If so, the module
>   	  will be called dmard10.
>   

...

> +}
> +
> +static int fxls8962af_power_off(struct fxls8962af_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	ret = pm_runtime_put_autosuspend(dev);
> +

could drop extra empty line here.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to power off\n");
> +	}
> +
> +	return ret;
> +}
...
> +
> +static int fxls8962af_reset(struct fxls8962af_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
> +				 FXLS8962AF_SENS_CONFIG1_RST,
> +				 FXLS8962AF_SENS_CONFIG1_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* TBOOT1, TBOOT2, specifies we have to wait between 1 - 17.7ms */
> +	ret = regmap_read_poll_timeout(data->regmap, FXLS8962AF_INT_STATUS, reg,
> +			(reg & FXLS8962AF_INT_STATUS_SRC_BOOT), 1000, 18000);
> +	if (ret)
> +		dev_err(dev, "reset timeout, int_status = 0x%x\n", reg);

Should check for -ETIMEDOUT here rather than generic error? and handle 
both cases.

> +
> +	return ret;
> +}
> +
> +static void fxls8962af_regulator_disable(void *data_ptr)
> +{
> +	struct fxls8962af_data *data = data_ptr;
> +
> +	regulator_disable(data->vdd_reg);
> +}
> +
> +static void fxls8962af_pm_disable(void *dev_ptr)
> +{
> +	struct device *dev = dev_ptr;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	fxls8962af_standby(iio_priv(indio_dev));
> +}
> +
> +int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
> +{
> +	struct fxls8962af_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg;
> +	int ret, i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap = regmap;
> +
> +	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	data->vdd_reg = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->vdd_reg))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
> +				     "Failed to get vdd regulator\n");
> +
> +	ret = regulator_enable(data->vdd_reg);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, fxls8962af_regulator_disable, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
> +	if (ret < 0)
> +		return ret;
Could consider to use if (ret) consistently throughout this function?
> +
> +	for (i = 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
> +		if (fxls_chip_info_table[i].chip_id == reg) {
> +			data->chip_info = &fxls_chip_info_table[i];
> +			break;
> +		}
> +	}
> +	if (i == ARRAY_SIZE(fxls_chip_info_table)) {
> +		dev_err(dev, "failed to match device in table\n");
> +		return -ENXIO;
> +	}
> +
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = data->chip_info->name;
> +	indio_dev->info = &fxls8962af_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = fxls8962af_reset(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = devm_add_action_or_reset(dev, fxls8962af_pm_disable, dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> +
> +
