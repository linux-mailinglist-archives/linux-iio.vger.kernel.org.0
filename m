Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB37728804E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 04:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgJICUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Oct 2020 22:20:03 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:32353
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729724AbgJICUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Oct 2020 22:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3+aDCSIGNCmZrBcacVF2ZySAhChZoMrK1E7dULH3Ah/AcdaEfYUy5dYaUN2J49PTc42TrJGi/+iCqU1cHZbpK7eXjGfsvBH0jcLmE8TkTN02WaPyLv4dPn/0FtMZR8zdlWI1z0zPC7aFOL9nNLF91jb1EjyaP17jrSP36dBXAixBVRFxReLYw3oBAkMejmbCXSepYDlN2Vm7phVLuEFlHd2LUvjfWdQZJ00GJ7SRh34ysHwagh2jKkc8MSobBxB35+FofB5tEK1zZAEARcqAgcJToxJftrFkhg8W6ns15N5xhZN+c3y2sxpqDDKzSmZQs2vVV5XyVPYGF/+2RciRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGe+8mHcdliqYDwZgNmE6dpk7Zyk46XmpWzWoorGPak=;
 b=AsePBgDH/ZVFUfgVPrgyKTpW8VFTeVDvytKAB7DzgE01TQ5mIpKmhiSLnv2LZ7n+fcwF+UAUdrrRzeuKG2kDjJPEnZLUNde+T0SRYS/1hm+R5PQGPHNKwMy0fJ9mEM6gD77u1AhasO/Mkfg5ItIWoG/Ta5YotcrIYPcFbXo5HGYG5XuRJT9viTelHpR9w7jX7i87YjDZJsWWEiS/oTTKeTM/XBOdO7XPhq2OACXAVNY/YfCZY2tOQwpr9a5o1OBD87bwd1Z05gae/Nd4QOGzT1zXJ7QKf4XPD3cAq23OPeJR1iNY6AuyMDpvSEN2M0dQdqwSF9XDjHXJQb1S70ORMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGe+8mHcdliqYDwZgNmE6dpk7Zyk46XmpWzWoorGPak=;
 b=NrsTz6nWPVk7nlA9sJMQM8h4N8vbgjzDGjJg4LCwVoPXK/f8Qq2vKhH/lTGLZpIJu2hruZsl9oGCea4xgBoXmMysoCUKh5S9hgBAQq0fvSqNrdxQ/otIWiPtnS5pUzxvvOX+6dGgAXE+l06CPkuxQeCB34hTD/tnorJ3hUFer94=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4031.namprd08.prod.outlook.com (2603:10b6:805:20::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 02:19:59 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 02:19:58 +0000
Date:   Thu, 8 Oct 2020 21:19:49 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201009021949.GA3629@labundy.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
 <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
 <20201008001424.GA3713@labundy.com>
 <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: DM5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:3:13f::24) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 02:19:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e95a79f-56a3-42a2-ff1a-08d86bf9d1bf
X-MS-TrafficTypeDiagnostic: SN6PR08MB4031:
X-Microsoft-Antispam-PRVS: <SN6PR08MB40312D281C69051978EF22C5D3080@SN6PR08MB4031.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u53eoY4+Tsi0oesCCdzD8ndUwIL5IK+LTBnMVlni2XeKKYx1x77RZ42AmruBG7TBxKbad3gkBLV8gbNxahL643R+f6NT3To1dqcla0Qkmknlj4J7zLcxPqDLQf0XD/SNXvf37KXdwuhIveHuPeruDDdTgfpymvhuOafQNyzF00n8E8YE7I2XZnFCmNwkicR9pqmSrpj8KdzLPHy75KpNFGrLElekmxfRzcJEU3F9kZToG1KaLqL/YnKRo9s+hNCKQt4pcZOZoI9zgL3hE5u9mPLf3srPRNLL5ieUJYirsBQ3ZWSWbxI8zzh1PnYUwDwznpJrZyCfzdjTu1mUi0839w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39830400003)(136003)(376002)(346002)(2906002)(54906003)(33656002)(1076003)(316002)(5660300002)(478600001)(55016002)(66556008)(66476007)(52116002)(6916009)(53546011)(8936002)(2616005)(83380400001)(7696005)(6666004)(8886007)(36756003)(8676002)(86362001)(26005)(66946007)(186003)(16526019)(4326008)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wV3iG8MVhcb6jxs67pPLfOOx+Bek7OKQBVSKZXjk/UT6eZiGdIpCurJgsDmPR9CpbZEQg9tlndUsnHP05p8nDdGhigQ7cpEhb0F0qPEqkru0rijBBGhGA2pvMr0+DpYqS7ACR2R22w6L/k+3gQDAenVm8cpt6t540HWx5l+zY4ahoK6ZV4mW3hmDHrE0vjaYb35PKJpt0srb5V/UGI8AjuPdlazSnMMFiqv8tcKrFtZTZ3s7sl5pZSI5CTYY3AMfSFiLC6cXxX3m83acsX3Ptm05L2VLaupoPxRsy+H+861psBN9rKGpbSpPFOC0CX4mTp6xfeN0ZmtdDLPpV7yrieLSoNM4XDH+p2XAWjrf3Q2yZIL1ecKgB7Afm57ZvzI0XeI+l4XMJJ20rZTOorrRGat6AEg+bu/pPk6daLm09OeYDoVoNc4EMzrOFPLBfYgPiRN2g4x+AU5DLLtFC6RK8a7YRSbUKaPu+hK/u0iMUMOxOl/dbcuNA8UIYfCExwoSNSRNC3eyhtVjhY49/5PYLFxwXUOrnz+KVdQWJIvPPGcSzuzdtkOLmLhKuf7/psMWSVp0w97f5qExj+z0P1zDNsFXpuU9eX7sVbOl5IjPdVkbXBcD4QO/QM3+im4uBGx9rDGplW1i3vDjmVLnAJ3doQ==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e95a79f-56a3-42a2-ff1a-08d86bf9d1bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 02:19:58.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URZaKcnXwWHzUJsNZ0j9X2ujiA4R1gs8Gvq7NdDh5/thIUU0ZI6pgf0AWddfCO1liJVklSFCHCca/0pT5Uv2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4031
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans,

On Thu, Oct 08, 2020 at 09:10:19AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/8/20 2:14 AM, Jeff LaBundy wrote:
> >Hi all,
> >
> >On Wed, Oct 07, 2020 at 03:32:07PM +0200, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 10/7/20 3:29 PM, Bastien Nocera wrote:
> >>>On Wed, 2020-10-07 at 15:08 +0200, Hans de Goede wrote:
> >>>>Hi,
> >>>>
> >>>>On 10/7/20 1:35 PM, Bastien Nocera wrote:
> >>>>>On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
> >>>>>><snip>
> >>>>>>>Dmitry, any existing stuff like this in input?
> >
> >It seems we are talking about "specific absorption rate" (SAR) type
> >devices that signal the WLAN controller to reduce transmitted power
> >while a user is nearby.
> 
> Yes and no. At least the lap-mode detection (laptop on someones
> lap rather then sitting on a table) is currently used by the
> embedded-controller for thermal management decisions, basically
> when on someones lap the configurable TPD of the CPU is set lower
> to keep the laptop's bottom skin temperate < 45 degrees Celsius
> (I think it is 45 but the exact number does not matter).

This is a much-appreciated feature. :)

> 
> The lap-mode info is currently exported with a thinkpad_acpi specific
> sysfs attribute with the idea that userspace could potentially use
> this to indicate to the user that turbo clocks will be lower
> because of this.
> 
> With upcoming WLAN cards with configurable transmit power,
> this will also be used as what you call a SAR device.
> 
> AFAIK the palmrest case is mostly a SAR device.
> 
> Note I'm explaining the alternative lap-mode use-case to make
> sure everyone is on the same page. I completely agree with the
> gist of your email :)

Acknowledged on all counts; thank you for this additional background
information.

> 
> >I just wanted to chime in and confirm that we do have at least one
> >precedent for these being in input (keyboard/iqs62x-keys) and not
> >iio so I agree with Jonathan here. My argument is that we want to
> >signal binary events (user grabbed onto or let go of the handset)
> >rather than deliver continuous data.
> 
> I was curious what keycode you are using for this, but I see
> that the keycodes come from devicetree, so I guess I should
> just ask: what keycode are you using for this ?

The idea here was that a vendor might implement their own daemon
that interprets any keycode of their choice, hence leaving the
keycodes assignable via devicetree.

This particular device also acts as a capacitive/inductive button
sensor, and these applications were the primary motivation for it
landing in input with its status bits mapped to keycodes.

I don't think there are any keycodes that exist today that would
universally work for this application. The couple that seem most
closely related (e.g. KEY_WLAN or KEY_RFKILL) are typically used
for disabling the adapter entirely or for airplane mode (please
correct me if I'm wrong).

To that end, I'm keen to see how this interface unfolds because
SAR detection tends to be an available mode of operation for
several of the capacitive touch devices I've been working with.

> 
> >The example I've shown reports events as keycodes since some of the
> >events it can express represent momentary conditions. In hindsight,
> >however, an argument can be made to express some of this information
> >as a switch (user is or is not near the device) and the new event
> >codes proposed here seem like a step in the right direction.
> 
> I'm glad that you like the new proposed switch event-codes.
> 
> Regards,
> 
> Hans
> 

Kind regards,
Jeff LaBundy
