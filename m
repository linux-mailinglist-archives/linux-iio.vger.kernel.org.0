Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19933AF46
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCOJuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 05:50:17 -0400
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:53956
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229644AbhCOJuF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Mar 2021 05:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ+Lc7DMtGTPhtP/UUTTtBevkzeiceZ/aYT7C6XG9AOzzNiGyoObv9np/GdrGd1hOIKcClqyynCDcs0z7wBSLGSd+SZuf8E7ZRDzWacWe1gXmLB7e3IjBT/g6RYOqt83EHnFpr6CVC8hy8OlC2kcnqNvVuKj5/N3LxtU2x05bgqksfxc42M/4NJKM0kg9jdQM+xtg7MtQtQSdOuE4NeFnZVON5dZ6LNKMD8R+wfUyboA9OqJKlq/A+o8t1J7khT0CaO4pig6W6+5gziS5TcQAXebgVp4VkAWesi5Lf2Vb57J7D9Po7z18rZLctBAQEwHmKTu3zaJV2dZBp14AgkQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6Ge8QDBXgZyUI9wqnLKxKvAfml99RiqlsRyRZsspsk=;
 b=SCICNj7vTR5ixYhogbAVxMEDlyTzUwSrEhFyeJhOx0EwBXelHRCjBX/XbrcidKS8MmsIv3/VvB4/GUVHQA+ZPqwtNkdJ4+Rj57tn6e6aeGQvJFIcQxvbdZRomyf0xF61MBwHOmWJo7MFjsZE7dz3y31UqLZXWTWVy8cK3MtuwxjUgIXP6JVuT9MKskTfQSWd4RU9cDqmWC0A9JLGwejL9lcFxooyMVaiw8hIahfZnwIyO/Ss5/0kwfpXh0NRV1/QayZm9HHI3X2AVJnhPlz6mwka94GoIRQA+Z+vxPhJdlZo3KJTTcs9tDvcv1SzfKSWyVhB5chnpZFO386NdTfyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.48) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6Ge8QDBXgZyUI9wqnLKxKvAfml99RiqlsRyRZsspsk=;
 b=C5f/4F1yEXRLX4gcmb9d0L0i7Dpqz82nA0x7Vb+DfJv5cnbjaa6tG3KinXTlcyG01n8C66Yp8a5T4TiSAVXphmhKk/Ru2ITTHn8KKOqGJQo/NX8uFdex9fWpDzij+W3Gt/17ORfk+jwFtfF0IiO9Uv9Nt/DXjB64bWwaJPqapsQ=
Received: from AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) by PAXPR06MB8031.eurprd06.prod.outlook.com
 (2603:10a6:102:1ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 09:50:01 +0000
Received: from AM5EUR02FT006.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::2d) by AM5PR0601CA0026.outlook.office365.com
 (2603:10a6:203:68::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 09:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT006.mail.protection.outlook.com (10.152.8.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 09:50:00 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 15 Mar
 2021 10:49:52 +0100
Received: from [IPv6:2001:1458:202:121::101:cf2b]
 (2001:1458:202:121::101:cf2b) by smtp.cern.ch (2001:1458:201:66::100:14) with
 Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 15 Mar 2021 10:49:51 +0100
Subject: Re: IIO advise + help
To:     Lars-Peter Clausen <lars@metafoo.de>, <ardeleanalex@gmail.com>
References: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
 <c41ae3c7-ce3d-9036-280c-b25354bea22b@metafoo.de>
From:   Michel Arruat <michel.arruat@cern.ch>
CC:     <linux-iio@vger.kernel.org>
Message-ID: <44a659fa-9929-81fa-9761-4214b7083b9e@cern.ch>
Date:   Mon, 15 Mar 2021 10:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c41ae3c7-ce3d-9036-280c-b25354bea22b@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:1458:202:121::101:cf2b]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c77dca0-60b2-4557-3731-08d8e797b36c
X-MS-TrafficTypeDiagnostic: PAXPR06MB8031:
X-Microsoft-Antispam-PRVS: <PAXPR06MB80313DA7D724CA2BE965AE03EC6C9@PAXPR06MB8031.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi8aMVPqv7QcqNHkmuz2j3xGtBFmeJbXqq4NNa5lQzYHg2yFaN/ldi80bf361AYjqeGST3zY5wUeisl+bmwTZ4JVLISMwLFje6S09ZY/n14TakHFvX0Yd/Q0WCsd7r1h/URJZzlXnq72kFQaHC8YH3EHl/yrFiNtpevHv8kIRjyz/WWAXW5IeSgTAu+4fMVpNPF5R3qLwNHn91XYkY5ev7wY5AI0A8eh8p+sP+KvzYxGPqGdjTEhYqsgusTX5Pj9kIJqiOMC9Xk1Tv38gHfritQ7Oamy6E6bQ1vjhAB9t/aP5skAixgdkC9i4PZYE40j384HcCp8SwR/Je7JFMyWfTgynXeewd8tL9EQtcPJcX82QSTbTviTxyvhh6ghS4k012Mn6WFIYDBZ1XtCixdVJGs8T0VbyaUZQFLkNZDd5Fflh8sIylJjsFNdiITgvJY5g2R7YMVytSyfA8aVZdUXWfiIcaczOXcE4gzPYL/tAPRt84fcVgQJ7W3vMpA2MhekAn9B4sxWLoYj67VjD09SSKKp46nB0TkVJqtzEEfvvhGthlksVU1W5rHIHM4T/0+I0BK0WN8+XivmyuU2qpffs2ljy7auNhRVX0SMgdhz/YMvzmpSvVoNwKdOF+9ogjjd+ouokNaSvsJ9n8uz0NGXzhglABluNh7EqKon2+yx2m/gX+Y7ruB+EUX4H5YFTwPex6X0BNvuS09q7RruXJVnyPvE3mM3GOVcg1353sBNuXEO33eqg7X1GC07VUd5qC28sXcrNeZPiy7QYZMEMi0W3g==
X-Forefront-Antispam-Report: CIP:188.184.36.48;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx12.cern.ch;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(110136005)(82310400003)(426003)(36756003)(44832011)(36860700001)(31696002)(966005)(82740400003)(53546011)(8936002)(2616005)(86362001)(316002)(4326008)(7636003)(186003)(16526019)(478600001)(26005)(47076005)(31686004)(356005)(8676002)(2906002)(5660300002)(70206006)(336012)(83380400001)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 09:50:00.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c77dca0-60b2-4557-3731-08d8e797b36c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT006.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8031
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear Alex and Lars and IIO Mainteners,

Many thanks for your detailed, helpful and quick answers, I really 
appreciate it.
I will assimilate all your informations and links and let you know how 
it goes.
Best regards,
Michel Arruat.

On 3/13/21 11:46 AM, Lars-Peter Clausen wrote:
> On 3/12/21 5:54 PM, Michel Arruat wrote:
>> Dear IIO Maintainers,
>>
>> I'm starting studying IIO framework in order to migrate our 
>> acquisition systems, based on fast ADC, to this framework.
>> So far we are using our framework named ZIO which was developed more 
>> than 10 years ago, when IIO was not mature enough to handle high speed 
>> constraints, large DMA transfer(>256MB) and zero copy.
>> Out of curiosity https://ohwr.org/project/zio
> 
> I did have a few discussions with Frederico and Alessandro back in the 
> day (maybe 6-7 years now) about what can be done to combine IIO and ZIO. 
> Unfortunately we couldn't quite get agreement on whether it is better to 
> have one or two frameworks.
> 
> One thing where IIO and ZIO differ is that IIO is more around streaming 
> data, while ZIO is around packetized data. In ZIO when you capture data 
> you get a header with metadata.
> 
> But having support for packetized data with metadata in addition to 
> streaming data is something we wanted to have for IIO for a while now. 
> Just nobody has implemented it yet.
> 
> I know that there are a few people that use IIO with packetized data, 
> but it is sort of in a hacky way where the userspace application uses 
> the streaming interface but captures exactly the number of bytes that 
> are in a packet. This sort of works, but having proper packetized data 
> support would be nice.
> 
>>
>> The idea is to get rid of our local framework and move to IIO to 
>> benefit from the large Users community.
>> For now, most of our drivers are running on x86_64 architecture, even 
>> if future applications will run on SoC (Zynq UltraScale+).
>> I made a first prototype, widely inspired from your "ad_adc.c" driver 
>> found on your git repo, with a 4.18 kernel. I am facing some issues 
>> including kernel Oops while unloading the module.
>> Could you please let me know which minimal kernel version is required 
>> to use the "IIO DMA engine buffer" features. In addition, I would 
>> really appreciate if you could point me to some reference IIO ADC 
>> driver implementation that handles similar DMA transfer size with good 
>> performances.
> 
> As Alex said high-speed support is still in progress of being upstreamed.
> 
> I do maintain a set of branches for recent Linux LTS releases which have 
> a minimum set of patches to get high-speed support enabled.
> 
> See https://github.com/larsclausen/linux/branches
> 
> Maybe this is helpful since you should be able to easily import them 
> into your kernel tree.
> 
> - Lars

