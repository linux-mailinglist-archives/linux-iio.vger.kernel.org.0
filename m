Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44A91BE810
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 22:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgD2UDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 16:03:19 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:6182
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgD2UDS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Apr 2020 16:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUY0TfiRec0HB71ir6k0D4fQsXkUgLSxzdSruL3MSiieLicIzvkh0GeNTmQJ5zzF7w19H9xMCRRWiRh1keGSLVV0VdIevb2BGrd6TrxtRdH6dSdNgHPun4NW8mY7EO7LXv7IJsou9uCgThPPZPQSqpC+SQbGHC2RiKmmc6p5L9AfaueSZwk7WUreh3AGgVIw82RkcJYc7r+nd8KHaYyVooxdXqTPgaHthKG3VfK9ApajjTu66dbm2AfS5dy8w2rDgOD0j7fhBBB2aCGDsi+Bw/OxuMJRxSXCJdyOv7jCprX0a0WQw7b+yyNURZf92dhrS/j9nnfLHI2g2j0vGtAxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVz1khITgLQ0WWroIgi7dXyBmYuVP6VqqGUYJw85kPI=;
 b=QMSuG9sjevWAaw62RZ4tTnxncI4rijoiXgRnN/dGA3pHOsI25b+nXOywcZwmgISbxOlUHBF8RDCtPpdMPbmBy7/HyH7g7InPK1VFsflaa6TSh1n6AwNeyyCo7SFpvIgMIGT9RPwJaVIuOkaPhhhLaz88E0IBdoUN6e6oPdLGc6SYvMNNDdD0yfU0qb51z0p+ryG7QHrk8j/lGFzG+H2B7SbAP0UkuEeElftqNSWReU3AV3JwLkGZmkly8n44FjZBFdueIrFet9RjMcfHcPpj1EyaDJe8gxm+64hMotW4cHBxCB639UVIDxrtRWinoDc0DtItvUISHSIKBs684YZulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVz1khITgLQ0WWroIgi7dXyBmYuVP6VqqGUYJw85kPI=;
 b=w/Vibmk6g8bWOMLwLkMC28UZ4LXqimzwnjHQvwGWNKgXMpSmwtEMmj/LRtKLNSx0HiRhCCf8z1k9T+NeC0oLHo5N024CBToM7Ybt2a48FUQk6q0y0q9sPHV/hgBWmKH7jqp/05s1P8WPUUn6BLKwCQupyjcjyalFYLZKvS3n82s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 20:03:14 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 20:03:14 +0000
Subject: Re: ucsi and DRD controller interaction
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
 <20200422142808.GE618654@kuha.fi.intel.com>
 <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
 <20200427120032.GA2351955@kuha.fi.intel.com>
 <b139b18c-0452-d717-856e-14b9dd03910a@amd.com>
 <20200429124321.GC2738754@kuha.fi.intel.com>
 <20200429130315.GD2738754@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <8ba98ceb-8a69-be7d-944e-f2b96c12bf1d@amd.com>
Date:   Thu, 30 Apr 2020 01:32:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200429130315.GD2738754@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::15)
 To BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (202.62.82.154) by PN1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 20:03:11 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1278802-b265-4e1c-d77e-08d7ec78594c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:|BN6PR1201MB2496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2496A9646AE1D6F2003ED42AA0AD0@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(6916009)(8936002)(66476007)(66946007)(53546011)(66556008)(36756003)(52116002)(2906002)(6666004)(5660300002)(26005)(16526019)(6486002)(478600001)(31696002)(8676002)(956004)(186003)(2616005)(86362001)(16576012)(31686004)(55236004)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwoD0+m7YM5TR2tGqeMkJtIcSsVPE0oh2JdVSjVW/QijSaOzBHTgManjzkKuNBSuZTx7pEyAlIW3PuEeVuyVjTfwDHFlbOuvhpuEtYjHH8Mgl3eW50juqYVjNbx+W7/evnuJiOR8hJwizg2fcZBNBsC8zK3tA1zWr52+KUBvqIc0NT8LunGEerQKsItnHfJLiTE4kribih1Usc7W4gc3TCnJTiZum1fOL+7QFF5C7CyfE1ug3K8Uos1mPpBwBxqjqKDXNkwdYt1Nukr+3kDRRy8USDXZ2NRyzScDnqYzOjy4yHeNEB/+1q+5HbqETsxDwf3RcRQwfjldBAsZJNAZgBMwhD8XgPz3N7DH9Ky1tdTOGIh3BtM1cH3c+Oa28cLbaigoCiMaCj09i3NhI3tJeIiWuDo7KdAoenevbg62omWE3azRfsoLqFBkw62EyCvU
X-MS-Exchange-AntiSpam-MessageData: 4JyISHWQw59Jocmqtea6kk65dIzjMCasfmbWcvIoLKZDClClMu0p104Ett4hbjHF3rKa1x+LyDnZOYpu5unZcX7ZAaYs4rqieLT10n1sXq1lXQLJkYkGbNdRYzx/B8J3aDcbz3VZipEyNBNg2x+JdEzKG+y11oFo0a+0ejsV2Txqe50SX/KeRpeVfQY8eV4PVpEE5uKz9Y7npeRnQdNzdFgeisSzyb0TpYilQdYuMXoD+unM6lbVs9xYPkb2m/EwvUem4KxkHSpetMeMxXMQUiBVFfLhNsWVp2M843QfKq+g1PEZMdQOGR3wPCqWsT+OpyLMIPBqK0wT13PxQXyTb16KWATc55Hc16/n76Nk+1dpfpFChdNLrse7FMUyg2/RyGg77Z761Z84Vzmd/QVBUiP7zywS2/ZsCxGkAsuL/9lwO6nuB59dGSM+oD5QQE9GclmBQnQX6Eg51qXNqR/NG6IG4fYCuWSpW+Wm1J71Ndg1/i/2vPFXYzaZp0E33puD0U8B6Qp5nic0ptqpkEYH+Cb29Q79EKX90kpozJj7niCQufxMxAGSoI5XF375RF22f1hubb235UwC0apkwoZjCABJAyIeBciVnsdRtMciYgh4zOQ4jb8HqiPjmQ6nhBGpIceFzYR0yljnoahcc3zaOtQMeCqzUg96s9/JnhzrKpMd04PMkGCS+ffwcKDPt0VzT/88/rjsEGXmAAEwsXE2qELSAF8SRrJu9+VIX6cEn1N4pVn7W+XdIRYyKu0NJKDzI+s0+tQarx1HrcyHarFkp/2e6DBjm2cNMCOumZ1iDmY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1278802-b265-4e1c-d77e-08d7ec78594c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 20:03:13.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fkE3YGxx2tt+Hu/JDQed9zxSVC1iCii9rfMyJ3/rqdraNIq41x75RcqgdhjvtJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/29/2020 6:33 PM, Heikki Krogerus wrote:
> Hi again,
>
>>> Thanks for the details so this will enable the role switch  for drd controller. Now for UCSI driver to call the role make functions it needs the reference of the same switch reference,
>>>
>>> so for that do i have to use device_get_named_child_node(dev,"CON0"), in UCSI Driver?
>> No. If you use the ucsi driver, and if your connector child nodes are
>> in correct order, then ucsi_find_fwnode() takes care of assigning the
>> node for you.
>>
>> But you do need to use the USB role class API to get a handle to the
>> switch (dwc3) in the typec driver.
>>
>> UCSI is really meant to be a status interface. The specification
>> states that the USB Type-C connectors should function autonomously
>> without any OS involvement. So by relying on the driver to configure
>> the muxes, you are actually corrupting that part of the specification.
> I had to recheck that. I seem to be wrong about this. It does not
> clearly state that the ports need to function autonomously. Also, in
> this case the USB role switch isn't a mux.
>
> Sorry about that.
>
>> I would still strongly recommend that you use TI's own host interface.

Thanks for the mail, in my view role switch is just software interface here to update the DWC3 controller for role change.

I may be wrong here but this is my understanding.

So on our platform PD is also connected as Master to USB/DP phy. Hence here is sequence as per my understanding during the role change.

1. PD detects the role change and update the phy register over I2C (as a i2c master)

2. PD also generated the interrupt to UCSI Driver (PD as a i2c slave) regarding the role change.

3. UCSI driver has to update same to DRD ( this is what we are all after that)

4. DRD will program controller register.

 I can implement /use TI's own host interface but requirement for us to have UCSI based driver.


Regards

Nehal


