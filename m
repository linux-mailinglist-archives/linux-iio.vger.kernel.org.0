Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69E1286BF7
	for <lists+linux-iio@lfdr.de>; Thu,  8 Oct 2020 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgJHAOf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 20:14:35 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:44736
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgJHAOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Oct 2020 20:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1xY409k1CYoEBRejn+o4Q7tdyeyVazMFFWmq32nE/8CM4U5WeJpmaDNCHVCoNkrO7xPgaRHw3+GJTmwkeRIrytWHzZlan+On/tp/TSLc0GQ8+cOXcKRsm/Pvi6O9C/WUwuK0z0fVweOHCVzSBB66e4H8UQRCjQ9H7r6bvzvD6hv0lzvQGUVM/+iVdJKwaKxX6rrmiOZFu+udKmEHjz/qHnPahO45kwqcBpiib9WmMcmJKMN8F8TG8ML/AWhqkjr0RnO6EfFaJK3xMkcLiVbyoukWLLwyUrIww9w2mQ32HgEPmK1jqBVefpk46CKJuDdEV4bI0x6r+VAh9v+yvDhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TETinzYmP/5Jrw9z+fVDDesifrpBjdNWvFMfOVNHRvM=;
 b=fwSCsjGJFaqhDST7A2MpyjlibxbZa/iYLkWZuB8Ol1xKm9l50shKjEof4sBeI7S3hFkLso8abn83rMy3y22RGTQE8WMeenoALkRmakJBqrYdVAvDr06UukTI40oTHfqFU02KPy020pX1Jp3hKFDF92ULYsrZXzSyUbxsWyLfcWcnN6vh3eFa4b/3ClSvZzzCSLEIil4sKGgDDcLAfT/fO0JR5KSBtT147cPn2B3zPc2jYcBBLTaG6OYSpqNa8DsoXc7pieyq6Fhe5tGDf6KbKwUI0pvd1zr3MXHYf33BRgLKYVgKKkMfgZE92sRSZdM+EhQc/0qOL+jz5xTqnZEN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TETinzYmP/5Jrw9z+fVDDesifrpBjdNWvFMfOVNHRvM=;
 b=NW5D1JaoblTnmBaT5uBG4otk06DUpybok44vmZbXc4CK+MmkTAqFNDs2wtQKc/CtmOLYvd+uZQBXisy+ajsiTi6G24QXd9TQp5Z/xiV/B/qTGdyqoEuv2p5D4TFB1ei7u/6lIom8loaZuPI2FxEkmF1noHt0TFVh9+nbQrn+O1c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4095.namprd08.prod.outlook.com (2603:10b6:805:24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 8 Oct
 2020 00:14:31 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254%7]) with mapi id 15.20.3433.044; Thu, 8 Oct 2020
 00:14:31 +0000
Date:   Wed, 7 Oct 2020 19:14:24 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201008001424.GA3713@labundy.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
 <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: DM5PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:3:101::23) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM5PR22CA0013.namprd22.prod.outlook.com (2603:10b6:3:101::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 00:14:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a5e26d2-b0c1-429d-31ca-08d86b1f20a3
X-MS-TrafficTypeDiagnostic: SN6PR08MB4095:
X-Microsoft-Antispam-PRVS: <SN6PR08MB40958B8D3ED44E3420742534D30B0@SN6PR08MB4095.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/PbwYgcqDQsDZ3Kj62hkRDcFjpWURBPw+Spgj72hTMW5NwZMbHynnns7AnrKcwEb9VbL3tvBBJIB1jc1OFF9b5kXw9Y0VXKcwIFPEOBnM+8XrkDKUmjL5SCUt9+JLuavo+tn/ijMxEcntB8Lp7Ke/sn/vaLNnboQIiIcAIKcmV6C2xRCEmBGN1LTHQPN+a68XkK6mK+4QttfrNfVsgpVbWMu92tl/PfHDSS66La4NWHjfmLYCN9AaPiY/q4+Cw5+qio835yJqb6PwPNatkqVq0NgGbhMpig7yv/mNSAZXdu0EW4I+ibxLilLSlEzNJ/Wf7cefR3EJzI2MhEcjY28g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39830400003)(346002)(366004)(956004)(2616005)(8936002)(478600001)(54906003)(52116002)(86362001)(7696005)(55016002)(33656002)(36756003)(316002)(2906002)(53546011)(26005)(16526019)(6916009)(66556008)(66946007)(6666004)(5660300002)(1076003)(186003)(8676002)(8886007)(4326008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DzvzLUsI/OiIaOIQ9d0puyVRXTDYLLh/zC3xClWXCxHZ6d1oZzBmo/4irGChmRCRokQYUknFmsz6Fs0fzwhGeFx0GkvcbCx8lejQDRLvGJC/H8cVssojzlcPJqorVWIAUaQHVH4sUkBrATXplgHU6wz42esk54/WnSpEfwJjN5yx1IjVD3SImsnM7U1Btd0rbfwIC9VB30TNaGg5udzzOCjoPnHLFmZ+HcqIdLvjavX1MAxRKcmoN5tFoPZDRbRb7FAuvLhRqwqaamoSc8ZtlKGMeNk2kxP3XAb2F5M3hfZ1Ou4S70ovDBNyIl5bKqCbG2kRGGTDocBCCGbdbp2w0k7WVFY1DTI1aCzSsN8gxQA/Y6jppE60JTAYTfjV+5nzj+obD8A6DuhSt3VUPp5xxfdyajgWIkdzjopW4b8TFmXRyvsVup1vOaP26154eJWHkCp/7MhnuDUNYVelM0IQiUdEH7m8YeuS+Yt8dGS+A3NVpQneti36/zNRVbg+Ah2I1c4m5uZfGB0p5g3QLd+1yj0cjBB94oCvIAsN+azH5I/273w8nI3skdcQcp1AKPawIBtIiHATBHATmEPFEllgqreY5Bf2+ehA3qE3Xdq2HLhpb2ypAf8GpEFbWf4O7T39N/CgnE1DH1oEUMCGNFe90A==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5e26d2-b0c1-429d-31ca-08d86b1f20a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 00:14:31.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyGCeqrBc3kgQ3NT3ZXnSlCzhBHwY1T20caDhoov78KPsDsICunbOc56lmTPoNstD1yQ9HAZZuUM/dobARbphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

On Wed, Oct 07, 2020 at 03:32:07PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/7/20 3:29 PM, Bastien Nocera wrote:
> >On Wed, 2020-10-07 at 15:08 +0200, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 10/7/20 1:35 PM, Bastien Nocera wrote:
> >>>On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
> >>>><snip>
> >>>>>Dmitry, any existing stuff like this in input?

It seems we are talking about "specific absorption rate" (SAR) type
devices that signal the WLAN controller to reduce transmitted power
while a user is nearby.

I just wanted to chime in and confirm that we do have at least one
precedent for these being in input (keyboard/iqs62x-keys) and not
iio so I agree with Jonathan here. My argument is that we want to
signal binary events (user grabbed onto or let go of the handset)
rather than deliver continuous data.

The example I've shown reports events as keycodes since some of the
events it can express represent momentary conditions. In hindsight,
however, an argument can be made to express some of this information
as a switch (user is or is not near the device) and the new event
codes proposed here seem like a step in the right direction.

> >>>>
> >>>>There already is a SW_FRONT_PROXIMITY defined in
> >>>>input-event-codes.h, which I guess means detection if
> >>>>someone is sitting in front of the screen. So we could add:
> >>>>
> >>>>SW_LAP_PROXIMITY
> >>>>SW_PALMREST_PROXIMITY,
> >>>>
> >>>>And then we have a pretty decent API for this I think.
> >>>
> >>>  From the point of view of writing the consumer code for this API,
> >>>it's
> >>>rather a lot of pain to open the device node (hoping that it's the
> >>>right one for what we need), getting the initial state, setting up
> >>>masks to avoid being woken up for every little event, and parsing
> >>>those
> >>>events.
> >>
> >>There is not much difference with the iio sysfs API though, you would
> >>also need to iterate over all the iio devices and test if they
> >>are a proximity sensor (and read the new location sysfs file
> >>discussed).
> >>
> >>>Where would the necessary bits of metadata for daemons to be able
> >>>to
> >>>find that those switches need to get added?
> >>
> >>evdev files export info on which events they can report. Not only
> >>the types of events (EV_SW in this case) but also a bitmask for
> >>which event-codes they can report within that type.
> >
> >I know that, I've written enough of that type of code ;)
> >
> >I meant a way to avoid having to go open each evdev, read its
> >capabilities, and close them when it doesn't, and re-do that every time
> >a new event device appears. In other words, can you please make sure
> >there will be a udev property that we can use to enumerate and filter
> >devices with those capabilities?
> 
> Ah I see, yes that should not be a problem since we already run
> a helper on all new evdev-s anyways (assuming we go this route).
> 
> Regards,
> 
> Hans
> 

Kind regards,
Jeff LaBundy
