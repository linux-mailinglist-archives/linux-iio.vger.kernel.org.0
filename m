Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8F4142A0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhIVH2r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 03:28:47 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:53571
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229697AbhIVH2q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 03:28:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG49YlSuidp1so5ZPt+J0XeFMbYlLCAFdlWdl8HJQkm2reMDvYZ13LoJsnJswAF9efpcdzq6K7AnEPkgK7/+AYVbTBE5Bd1H6Atlu8vvW/G5wK4G9JVYysCUeE8uNABz0Te0kAVAvdmB4P8aRW9ecE4zgO7kPPhQ0T4IXVWPAXd2548rO2xDDTBkmHoIJFfHvAzlBQczs613SGv1TYL1dvO2VYU2MXiwgw1XZnxQdZ0qC+AoRBabEdk7mAeBLuw1nlvPxyX5YTOlt/fJxxqyG8ucSeucv06c5r64djlAx/TAyHUkO3uYd9EXtfBxsiz9uP4tCfVvO7DuMtRoJO2uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tRvvPLRzrpj/AvaI73MkKScXej6avcSFliJeLbaOAZ0=;
 b=FibSLJtPv+6kJPZ/UmGbq+ECG5/kd04pw5tRDmsZZiMKxX8hX7+C3P1giM0owmIkFkd0PYmFoA6kn0F+UMVta/dQXDa2pnUNend9aCe34HLJMM1B/p27ZiCOvCm/x1QeXXbVfBFj/C039miAQ9KTRUUWpUGf4HFwrr28D0QSW+pjas0b+v2wrdOhqrYwcI19DgmvWB3xvJ/klCSxLms4ipWUOiH/3w4RdWQ7vvHsGTe2VcVOCD1NjtY875po1THbeTPo3XVgpMIs6Ihocgj3gPBBtQoynBo4XUyE1Ik+zASJ5bupkPPddR41yWkYyRIFI1fenHPsesRuDIHucBq+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRvvPLRzrpj/AvaI73MkKScXej6avcSFliJeLbaOAZ0=;
 b=pgsj8kGxv3zMWgDuuT6cH99iZCUioZg8aSV3pzjacgrfDr04zFx7qC7M3IHX0nEZlhclJj8sHaLVfL0hkKt7jd24A/l7PDr6MaJe7chGqJj9BeUL+xNMUX/K981LUgqTws/csry3zl/kHfT00VOIyOU9Bxd9zHJJavDeqcZ7DnQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7164.eurprd02.prod.outlook.com (2603:10a6:10:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 07:27:14 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:27:14 +0000
Subject: Re: Reading ADC that comes from a multiplexer
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-iio@vger.kernel.org
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
Date:   Wed, 22 Sep 2021 09:27:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by AM6P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be7cf5b-c195-41d9-b407-08d97d9a6653
X-MS-TrafficTypeDiagnostic: DB9PR02MB7164:
X-Microsoft-Antispam-PRVS: <DB9PR02MB716419E4E19EF16B1C95BAB4BCA29@DB9PR02MB7164.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skwg/pm4O3KLnYxgu8oE5FGFhzmFKr8iBEk7u4ZiyhBy9eFr9+gI3qY9xGO4ziHRQ6+/Nq0bwhcdTTLM+7thdSvMIfjbpdRCrWhJ8precwwWLAjQbnCf+eGrdaAQLMl0Nt/mW6nSoGaF+RLXNmIANxYg3pljDGALwQ92wFYWT6YhOFo/19S0T0T8Y0xxZKgXho+87/PXIQjI/wkwSXLVs/phXCKOPduvs/9RFPy/tFXVPXzPpM7LoUGO4C+XgmzbY3VQoxnS+hjyF7yedxtxCkD2tPK/uIwA1LS/xJ2z41YK5BUc8GTzB5Kh7tMRiuaSA9MMng8KFwNQsOwdHM3uag5E1kL9MB56dXzBOIlfNlQiMVz9SEC8VaSj4tyHGlkFCu83Kv4wW2KnAMlSpPKO19Gg5vLTdBCQi0dK9/lQC8rClxGOCnxjKOdFQeD11wjWGIGo1oFg4h/3Up1ZrFYzyhq+Td18XRPemkqLC34wGlJ5Giq2nTyw6yCvl5+diUy3Aw4LFLpj5dF5hPXZHkP5DmvDJRTPNI+p0j9kX/ATwFMvkg0Wg0HGEJBCFn8oG5cg+4sQ2I9MxCua+TW2UnATAPqriGlUJ2RmZ5Kr26jHAMcDYLjsQKmMFzGWkXc6+VivRqhjjFTWqVLXKnafFoDgJOF4vRxRL3p4i3X2aLIP6dl9YMEsHsfpRB79wyxkG8Syp2+vnJt9QRL7o5espthNjBUUKDhaEnj/v+brAHFVMP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39840400004)(136003)(396003)(5660300002)(31686004)(16576012)(36756003)(956004)(508600001)(6916009)(316002)(186003)(2616005)(26005)(83380400001)(53546011)(8936002)(2906002)(8676002)(31696002)(4326008)(38100700002)(86362001)(6486002)(66946007)(36916002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emJPWlFWekM1MlFzVUt1eUFBRXNRc28vWmhCTkxmcGU1bm5IbWQvaTV3ZjRn?=
 =?utf-8?B?d2IvMG5GOSs2dUpXZUs4a3o0Sy9JMDR1MkYxUHFCSVBzSnlUZE9MSmZ1QnpK?=
 =?utf-8?B?RlIrY0orRktPeGtQM0loZ2FjT0hERXdUeEhMSStiWXdhQ3VuRzB5OG0vb2FV?=
 =?utf-8?B?Tk11dVo0WDNIMFkzU2xYSjJFQWswMkhBcTFNT2puZnRuTDhHSTFrR2VqaTN5?=
 =?utf-8?B?UEovTkViZFJabWxIWlBaRmk2dWN3bHJOektWd0FibW54eDdCSC9pVU9SZW1j?=
 =?utf-8?B?ejI0aTc4MHZOejZFdHVBdHUwNGI4c3NBNk40Zk1XeTNKQi9Yb1hwMnFIVHZ4?=
 =?utf-8?B?MWR0V04wcTRqRW1kZEwvejAySmt0NFlqdktseGJZMzU5MWM0ZUZ5OVJNc283?=
 =?utf-8?B?YW8vUGZkc28ycENHV2d0emYvZGh1cTdTaGFrZlphUjF6RkZGMWhzWjRMa2xk?=
 =?utf-8?B?U1RnNkJORkVuMGhQRm9xVElKenZMR1hkQXRtUUkrM3dHalN2NDV3TmhtN2Jz?=
 =?utf-8?B?TjROSU1ma1p1Yi9EcjhZR3V5aEI5L0gzZys3ZzZocHg5eDhIaE52TkluV2gy?=
 =?utf-8?B?Y2N2RkN3RU5MOFJrR0RjMEc1VHoyTUtzNVAwVFRzVlJzWkd4cjVYZlRKcE1J?=
 =?utf-8?B?YXk4Z1J2VnVaNVFla3JyU2NRZlR4ZlBqU2I4dlpyVWxueXBCT3NJREJ3WkJO?=
 =?utf-8?B?L3lkK25RS29uaG10d2l4WmIxaUxET3FMSm55WmlDK29EZW5LS0JYL1RmQ2Jm?=
 =?utf-8?B?TTJuZVRySTY1Y0xEN2ZvNDA5MjVGb1ZXS3JCTzVla3NhbkRPSGx1WC9xTU1o?=
 =?utf-8?B?TWJoOWVsOVlQUzU5RmFVbU44ZThXMHBqTi8wVFgxaFRTaVEzNzNML2VURmhI?=
 =?utf-8?B?Snp4M0sreHZCbExxZU9pOUgxY2pjM1JtSmpRU3N3ZGs0N3lRbElqL2QwVUd2?=
 =?utf-8?B?TVNBZkpGellFWnlvTHI5MWYzZHM1WUxZOTZYUktEZjhRTWpuSHR4cmx6RWxR?=
 =?utf-8?B?MEE0ckxWNnZNOWk0OFhiNCsxaHFYWW9PNlM3QnUvb0dBbjdXelUzZTRWMTZU?=
 =?utf-8?B?cStnVkh1elJPSVJXM2FjaFFyQlpheTMwc3pBSUIyYmZKUkFFUXhOc3M4U3Y0?=
 =?utf-8?B?OFpFUFozZUZWQWlJaHJLbG1YZ0NxZHRqUGt2NmljS253Q1l4aUhlTVpZSGc5?=
 =?utf-8?B?bEx1d3doTk5QdkhPZzBoM2l3anBzbnQrcU1INys3Q1lsZXNwdjBUWnFUcTlh?=
 =?utf-8?B?cWVMcUdCajExQkpzeTd3L1JWdE1JbENYTzQwUnpmaUlkb1NxOG5ZK1FTdG5j?=
 =?utf-8?B?NUlwdUFXQ2xCMW9kVDI1cjA0bnN1K2VXcFQxTEYyNHRvYWJFaWFoTzZGbEZv?=
 =?utf-8?B?YWwwV1JxY2lTUEoydVZrUWdOTEhEcC9tNDIyTCs0cWltKzFXOHladWhocGsx?=
 =?utf-8?B?aWkzY28zbkE5Y2tPUTJoUmo1b0FrOXFMQlFUbHpiRmZYQUFwL2dKT0JhcGRN?=
 =?utf-8?B?Y3M4eEcxVm5SS25oT2N6bVB5TkpJODdEVGRCSWFoQ0ZPVjJVVFo2cXlLWTk5?=
 =?utf-8?B?YXdoZDhpM0xybi9yeWNGUXVyQUhDUnhEMjI0anYyMlVNNmlpcThvU29kM2ZL?=
 =?utf-8?B?YkhmVjgvQVJZWHNxNHZuR0pNMVlGREpkSHlUc0E1K1JhRVczblZlM09walBi?=
 =?utf-8?B?ZUhIOWczZXRRYmk1Q3hqU1hpMndjTk5FTkozTGRLNklvcmR1T3JzbGl3ZCtT?=
 =?utf-8?Q?0rX/cA8rVRBOfYVco5ErSee1Cm0++fxDjqNMyXW?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be7cf5b-c195-41d9-b407-08d97d9a6653
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:27:14.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOQPN5hm5xk2tQ367jO4M88ISjknzEk6Pw1FkAyXCx2rGdCnNT/Z0yyelM8STUNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7164
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-09-22 04:18, Fabio Estevam wrote:
> Hi Peter,
> 
> I have a SN74LV4051 multiplexer that is controlled by 3 GPIOs and I
> described like this in DT:
> 
> adcmux: mux-controller {
>        compatible = "gpio-mux";
>        #mux-control-cells = <0>;
>        mux-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>,
>                            <&gpio3 30 GPIO_ACTIVE_HIGH>,
>                           <&gpio3 26 GPIO_ACTIVE_HIGH>;
> };
> 
> adc-mux {
>        compatible = "io-channel-mux";
>        io-channels = <&adc 4>;
>        io-channel-names = "parent";
>        mux-controls = <&adcmux>;
>        channels = "chan0", "chan1", "chan2", "chan3",
>                          "chan4", "chan5", "chan6", "chan7";
> };
> 
> /sys/class/mux/muxchip0/ is created:
> 
> # ls /sys/class/mux/muxchip0/
> device  of_node  power  subsystem  uevent
> 
> Sorry for the trivial question, but I haven't found any examples.
> 
> What is the userspace command if I want to expose "chan3" to be read
> by the ADC 4 channel?

Basically, the whole point is that you simply don't. The iio-mux exposes
the channels as 8 new ADCs, and whenever you read a value from one of
them, the iio-mux operates the gpios for you, giving you the impression
that you have 8 independet ADCs. They are of course not independent, but...

Anyway, I have almost the exact same setup in
arch/arm/boot/dts/at91-tse850-3.dts

	mux: mux-controller {
		compatible = "gpio-mux";
		#mux-control-cells = <0>;

		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
			    <&pioA 1 GPIO_ACTIVE_HIGH>,
			    <&pioA 2 GPIO_ACTIVE_HIGH>;
		idle-state = <0>;
	};

	envelope-detector-mux {
		compatible = "io-channel-mux";
		io-channels = <&env_det 0>;
		io-channel-names = "parent";

		mux-controls = <&mux>;

		channels = "", "",
			 "sync-1",
			 "in",
			 "out",
			 "sync-2",
			 "sys-reg",
			 "ana-reg";
	};

(but with the added complication that my ADC is not an ordinary ADC, but
instead a DAC and a comparator, such that the envelope of an AC signal can
be detected by a series of measurements, and I only use 6 channels)

That's exposed to user-space as:

$ ls "/sys/bus/iio/devices/iio:device3"
in_altvoltage2_compare_interval  in_altvoltage5_scale
in_altvoltage2_invert            in_altvoltage6_compare_interval
in_altvoltage2_raw               in_altvoltage6_invert
in_altvoltage2_scale             in_altvoltage6_raw
in_altvoltage3_compare_interval  in_altvoltage6_scale
in_altvoltage3_invert            in_altvoltage7_compare_interval
in_altvoltage3_raw               in_altvoltage7_invert
in_altvoltage3_scale             in_altvoltage7_raw
in_altvoltage4_compare_interval  in_altvoltage7_scale
in_altvoltage4_invert            name
in_altvoltage4_raw               of_node
in_altvoltage4_scale             power
in_altvoltage5_compare_interval  subsystem
in_altvoltage5_invert            uevent
in_altvoltage5_raw
$ cat "/sys/bus/iio/devices/iio:device3/name"
envelope-detector-mux



But the above gets tedious fast, and iio:device3 can of course be something
else etc etc, which is why libiio is the recommended interface.

	ctx = iio_create_local_context();
	dev = iio_context_find_device(ctx, "envelope-detector-mux");
	chn = iio_device_find_channel(dev, "altvoltage2", 0);
	iio_channel_attr_read_longlong(chn, "raw", &value);

Hope that helps!

Cheers,
Peter
