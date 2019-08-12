Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1359B89CFC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfHLL3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 07:29:11 -0400
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:61498
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728543AbfHLL3K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed1V4/3DmWA4KLzaOQjH4npHnBHRPnLsIwJHKumVBNxFkB1ziRwH+X+K7PA9QW+i5f33Rt69qsXefM/RxY//GXdGY10jG+mtydUxqanAvb17oImzhYWw8GwN8fTIMLk0um2LFFNuICUwXRidZEgbX7NjONagJnW4M+ElzxF3NBY3yAfVM2yH9X2bK2AFuYmvOWU5c1cmd5f8b8BBJ6T/A6JgkthdChckD+tKd5bpywF8iK2yD7xvKpCGcxkdAcThrXVEVhqiIKb+/5cO/3wBwhP16nfFOO7CGuBW5kZihQSTiQCfh+cwU1K1j1ak70ROEHw5YCTx8RBZNeBQKqPf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xoulMBQhfxUvRF8ZgPI9LA/9FYBjWkrjvvLDxXVfkg=;
 b=SHWVGKWtCW9fm/FXx7fOc7WDL3Q5enrCYuDi10Uh+PEIJ7T7Pc5CYTJ6ie0jEgSx+G4QJYksudagNVI1Mc8ifIRMILU1XGR4de5R+HYDMOsd4miOY0suhXYDUMsTTXGtP09NJAkOE8LqePfjv6aHJD8kOH/yztCOCV/hCCSe/TUmoSxPPXjDi2iTSwrjKxNHW6OezveQjBC+rUMQvT8Q2NA4yOdc5sVT0xKrtVK03HkN/6tPCsuNCjVHpoHAk25tJPtSrFlMnhVveJK3slbDuyqNlB7/pP4R0/kp163Cc0bAyoHAMFYT6wnPEKFURf0HFxcyODpR/qWjVVXF07e5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xoulMBQhfxUvRF8ZgPI9LA/9FYBjWkrjvvLDxXVfkg=;
 b=seYqh60f7g+kW8IDaYbJwDvc/tx+D3WKQLAFiQFUHgsotJ2Zs5sKMKoFwZr12geBjG66+SvrDJFHen6niSaefLm0RS2xZF3hELFYVu4/gTq4Wa5pDaHDyPBlYDSzIGtm96a2YmbHAhFU1IzTUmB2vPZPSZVlMyC3k3kp9RINZXE=
Received: from SN4PR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:803:2b::25) by SN4PR0201MB3629.namprd02.prod.outlook.com
 (2603:10b6:803:46::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14; Mon, 12 Aug
 2019 11:29:03 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN4PR0201CA0015.outlook.office365.com
 (2603:10b6:803:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.14 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 11:29:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hx8Va-0003HL-NR; Mon, 12 Aug 2019 04:29:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hx8VV-0004Ps-Ja; Mon, 12 Aug 2019 04:28:57 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7CBSs3n027546;
        Mon, 12 Aug 2019 04:28:54 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hx8VS-0004Pl-B5; Mon, 12 Aug 2019 04:28:54 -0700
Subject: Re: ina226 as IIO device instead of HWMON
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        mtitinger@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>, narmstrong@baylibre.com
References: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
 <a3760f34-02a3-a6ee-6b97-2705612aa735@roeck-us.net>
 <7405c36a-797e-d25f-1a70-19f4a0b1de04@xilinx.com>
 <20190809145418.GA1096@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <df2c9d5f-a4fa-52a9-1b26-3553a0f9e2df@xilinx.com>
Date:   Mon, 12 Aug 2019 13:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809145418.GA1096@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39850400004)(136003)(2980300002)(189003)(199004)(45904002)(8936002)(2616005)(16799955002)(476003)(446003)(9786002)(2906002)(81166006)(15188155005)(81156014)(356004)(486006)(426003)(478600001)(336012)(11346002)(126002)(6246003)(305945005)(31686004)(4326008)(5660300002)(65826007)(50466002)(6306002)(47776003)(316002)(58126008)(106002)(63266004)(64126003)(65806001)(31696002)(14444005)(36756003)(65956001)(229853002)(966005)(70586007)(44832011)(70206006)(26005)(230700001)(53546011)(186003)(76176011)(110136005)(54906003)(2486003)(23676004)(36386004)(52146003)(8676002)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3629;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf58390b-a64e-4df3-93f0-08d71f184768
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN4PR0201MB3629;
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3629:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3629F1EA139FC94D715ED403C6D30@SN4PR0201MB3629.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HWg7OrKRsRZnrP462OkvqGbxWngXcFrsJ0Nsra+IMegYUYkllxRkgTqxmuRgPqJamzOYCDFOhPcqtYfdPD1gqmdizXa8zKqD3cePEIaaWlw0bHDrm3LFWlRlFsGfizdusqiH2h/W7NtmkojY4RB4hwdKP7PnoMuxbnP3fOk4SLlW2U0zvjypqMRp3IOK3fjKpPb7AtLjLeLUf8+2625UHWOrxz8dRtDfIBHJQlfqo925YxvtzPVBBDAbLb7briZ6s4tNH6fTzBEvabO4+K4b52PPWJEOPNwPbBJRDqTVDXFhwBzTpclDhDxv+w/5aOl2uDxLlg3GJp5WyQ9f0kWI2lkmFI9Jr8DOb2V4KwD/aLs6R9Qz82oi35zbgKlLKVB/v6aQBK902SqSwM/MAb5XRSeDBPUQ1IKufDOoWCpUdKA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 11:29:03.1034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf58390b-a64e-4df3-93f0-08d71f184768
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3629
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 09. 08. 19 16:54, Guenter Roeck wrote:
> On Fri, Aug 09, 2019 at 03:42:00PM +0200, Michal Simek wrote:
>> On 09. 08. 19 15:02, Guenter Roeck wrote:
>>> Hi Michal,
>>>
>>> On 8/9/19 3:37 AM, Michal Simek wrote:
>>>> Hi,
>>>>
>>>> we are dealing with one issue with ina226 on xilinx platform when hwmon
>>>> driver is used. We have board for battery monitoring with shunt resistor
>>>> setup to 10 Ohm which is out of config value in hwmon driver. I have
>>>
>>> Took me a while to understand that you mean 10 Ohm, not mOhm.
>>
>> yes.
>>
>>> Well, yes, that is a bit large. I'd be open to accept a patch fixing that,
>>> though I don't immediately know how to update the devicetree property (and,
>>> unless I am missing something, the iio driver has the same problem).
>>
>> There is shunt-resistor property in uOhm that's why 10 Ohm is like this
>> shunt-resistor = <10000000>;
>>
> 
> Yes, I know, but that applies to both hwmon and iio.  What am I missing ?
> Is there some overflow condition in the hwmon driver ? If yes, that should
> be easy to fix.

For hwmon driver the issue is with ina2xx_set_shunt()
where passed val is 10000000 (10 Ohm)


unsigned int dividend = DIV_ROUND_CLOSEST(1000000000,

				data->config->shunt_div);
/* 1000 000 000 / 400 = 2 500 000; */
        if (val <= 0 || val > dividend)
                return -EINVAL;

And on this condition you see that 10 000 000 is bigger then  2 500 000.

> 
>>>
>>>> temporary code to workaround this but I have also found that ina226 is
>>>> supported via iio framework. I have seen that Baylibre was trying to add
>>>> generic iio support to sigrok.
>>>> http://wiki.baylibre.com/doku.php?id=acme:oldstart
>>>>
>>>> I expect you wanted to use sigrok also for ina226.
>>>>
>>>> Anyway my question is if there is any standard tool which is capable to
>>>> calculate and show information from iio ina226 chip which is can be used
>>>> instead of lm-sensors and hwmon driver.
>>>>
>>>> I would expect that iio-hwmon could be also used but didn't try that yet
>>>> with ina226 chip.
>>>>
>>>
>>> I don't immediately see why iio-hwmon couldn't be used. Also, if you don't
>>> use the ina226 as hardware monitoring device, iio would be a more
>>> appropriate
>>> solution anyway.
>>
>> I have tried this and found that IIO_POWER is not exported via iio-hwmon
>> driver.
> 
> Probably IIO_POWER didn't exist when the iio-hwmon bridge was written.
> Patches welcome.

ok.

> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> /tree/drivers/hwmon/iio_hwmon.c?h=next-20190809#n104
>>
>> It is easy to add because ina226 iio export power via channel 2
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/adc/ina2xx-adc.c?h=next-20190809#n690
>>
>> Also dt description is easy to add. + iio-channels = <1>; to ina226 dt node.
>>        iio-hwmon {
>>                compatible = "iio-hwmon";
>>                io-channels = <&ps_pmbus 1>, <&ps_pmbus 2>, <&ps_pmbus 3>;
>>        };
>>
>>>
>>> FWIW, we should actually remove the in22xx hwmon driver at some point and
>>> ask users to use the iio driver combined with the iio-hwmon bridge instead
>>> (after making sure that the iio driver combined with the iio-hwmon bridge
>>> provides the same functionality).
>>
>> The functionality is likely the same but I would expect that with this
>> new driver we should get something more. Especially that sigrok
>> connection looks interesting.
> 
> Sorry, which new driver, and what is "something more" ?

Based on what I have read IIO (new) driver is capable to run kernel
thread and in buffer mode is capturing data from the device which then
you can read back. That's why I would expect that there are user space
tools which are ready to use and capable to simply enable buffer mode
and capture that data for you.

Anyway I am able to see ina226 via iio_info.
	iio:device1: ina226 (buffer capable)
		9 channels found:
			voltage0:  (input, index: 0, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 2611
				attr  2: scale value: 0.002500000
			voltage1:  (input, index: 1, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 678
				attr  2: scale value: 1.250000000
			power2:  (input, index: 2, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 88
				attr  1: scale value: 0.006250000
			current3:  (input, index: 3, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 2611
				attr  1: scale value: 0.000250000
			timestamp:  (input, index: 4, format: le:S64/64>>0)
			allow:  (input)
			1 channel-specific attributes found:
				attr  0: async_readout value: 0
			oversampling:  (input)
			1 channel-specific attributes found:
				attr  0: ratio value: 4
			sampling:  (input)
			1 channel-specific attributes found:
				attr  0: frequency value: 114
			shunt:  (input)
			1 channel-specific attributes found:
				attr  0: resistor value: 10.000000000
		2 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime

				attr  1: integration_time_available value: 0.000140 0.000204
0.000332 0.000588 0.001100 0.002116 0.004156 0.008244
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: watermark value: 1
		1 debug attributes found:
				debug attr  0: direct_reg_access value: 0x4327


but running iio_readdev ina226 locally is just returning error

root@zynqmp-debian:~# iio_readdev ina226
WARNING: High-speed mode not enabled
Unable to refill buffer: Connection timed out

But when I run iiod on target and
iio_readdev -n 192.168.0.208 ina226 | od -x
on host I am getting data.

It would be interesting to know if anybody really test ina2xx IIO driver
regularly.

It looks like sigrok support has never been finished too.
https://sourceforge.net/p/sigrok/mailman/message/35148318/#

Lars: Have you ever tried it?  I am using zcu102 for experiments and you
should have it around too.

Thanks,
Michal







