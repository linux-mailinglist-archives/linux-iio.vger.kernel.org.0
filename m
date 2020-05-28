Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6331E6C4F
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 22:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407224AbgE1UQr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 16:16:47 -0400
Received: from mail-oln040092004026.outbound.protection.outlook.com ([40.92.4.26]:19330
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407222AbgE1UQp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 16:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxDoJcTPyX3DbcFPhez/r0zdiN5BIHxtNiW+o02r2mUL1/ZJW+yK25RQk6wU8K3olr+6ZFU6mxJNbOeDlMqTw5/ahDb28I2d8lkH/HCYXEKfLt0/N9xHOFyjgn9+PV6KIu3CK2eH780es+DBPs87+roLjmd4rGiO/CA43yAmNc5mX2mvUxyn+9ZZmpMJYaU1iqsXUPKB891lx3Jjy2mRyYIVbPsAMIL7wOeSHtOu1+GzEX/P70b59JTYmn6LMcPPPT+fDQHr28KK913O2xcVT731Wi2nUn1CFaYY+JzJmyDCvsqxL2im4YkBBYL8hB4RIGCM7RabK2xq0LIijk8Fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUF3NIu4vH1658hnuHA4f8fvw9xlqzRmrF4oL5xv7KQ=;
 b=fep6n6jYhHmuXoCbCRWC94ZMnaApExb80w14l2Ia5YX0FNxIFNe6MYy1XCxTRLh9vGvc3SzhbzPnXIMqNzupT5aYne6Ng75m5+oCwQN7UW8jssqWay+LNh62cff1dgUQgpxLWXi79c0yCllOHEOA1P7r4YbSszOpU2KGGarQGAIJdQWzEVAUxtxswjsQbhHn7bx1VAPcJE5bYdz7nRYrxhuiaQ996dgvJD26dUgFlo4dvMTJhRT3aSYWLmjdy0lQwoTqa4irwNabpmF8n/YM9TvMTjD4wy9g1lmubrKI8Q1V1Y3hZl7bLtaIT/iAzkSNkkBmHe4ArqCcAXfJEbTU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (10.152.74.59) by CY1NAM02HT119.eop-nam02.prod.protection.outlook.com
 (10.152.74.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 20:16:43 +0000
Received: from CY4PR04MB0663.namprd04.prod.outlook.com
 (2a01:111:e400:7e45::4d) by CY1NAM02FT029.mail.protection.outlook.com
 (2a01:111:e400:7e45::399) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 20:16:43 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:DD68A043FF37481702F0489AA8B89A4C3FB41AC1A00EA816F2C6BFC7DA555A22;UpperCasedChecksum:3091E124705B9F3557917C5565148C3AB13E644E5DA37BC08819D98A8F542112;SizeAsReceived:9179;Count:50
Received: from CY4PR04MB0663.namprd04.prod.outlook.com
 ([fe80::a537:5f2:5317:2c25]) by CY4PR04MB0663.namprd04.prod.outlook.com
 ([fe80::a537:5f2:5317:2c25%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 20:16:43 +0000
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding for
 current-from-voltage
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
References: <20200516022619.30779-1-xc-racer2@live.ca>
 <BN6PR04MB06600A3AFE160C6E07BF5B2CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200528201306.GA594238@bogus>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB06639E2715E2E965F12360DBA38E0@CY4PR04MB0663.namprd04.prod.outlook.com>
Date:   Thu, 28 May 2020 13:16:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528201306.GA594238@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:300:6c::17) To CY4PR04MB0663.namprd04.prod.outlook.com
 (2603:10b6:903:e1::20)
X-Microsoft-Original-Message-ID: <27636618-a043-1e33-6307-b256d19c64a5@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR04CA0055.namprd04.prod.outlook.com (2603:10b6:300:6c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 20:16:42 +0000
X-Microsoft-Original-Message-ID: <27636618-a043-1e33-6307-b256d19c64a5@live.ca>
X-TMN:  [/Xah2Df2zcUXqx0IAaryNncU7V4r1BvNTOhMCk2xorRc/sXsDY9PcZ04mOtqeEHD]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 67096e1b-b9c8-465f-9b0a-08d803440990
X-MS-TrafficTypeDiagnostic: CY1NAM02HT119:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObmKISK1maBDDAI80aKpU/qLIc7XKO4KTL/LBdiPhCp4lvbh/ie0iU2F0Uja52MNa7SGA6ijYt3y4Cwdw0ll/wxSrfbzCfF9Yq9jkj2Hf3ikzB9bm2e3rCMfizzJrgeBkUSsE/BSOZeCY+gIbJueppw9lQeIDz3OQ2A2tQWqMId6ht/xk4hZXcXEyazxvCenI+piy5wgfwDbY1Ia2xNQo8KqUK8jWLb2yMziZ8jzl674dox8WRLX68jKBA+htAxQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB0663.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: s4e8VwcqvuF8M6Ci7L7IAHi+ya/EUifwkemkLjTTdhFB7muKIHzdWCJXJKCxEGxJa/f6/hG4yOndITZeDy0GHzBUxJil1/npc4ltVsX/PcYja3B4sMZZl73WDn/YxZFUTP36sG1ruYPUFjMZxtml23UDIhgLP9Zz1S+mGo+22h5vbETXQYFgjGAkJfr1OAsWU33PWz/XNBJdWKFwqUKFgg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67096e1b-b9c8-465f-9b0a-08d803440990
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 20:16:43.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

On 2020-05-28 1:13 p.m., Rob Herring wrote:
> On Fri, May 15, 2020 at 07:26:18PM -0700, Jonathan Bakker wrote:
>> Some devices may require a current adc, but only have a voltage
>> ADC onboard.  In order to read the current, they have a resistor
>> connected to the ADC.  Add bindings for this possibility.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  .../iio/adc/linux,current-from-voltage.yaml   | 47 +++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
>> new file mode 100644
>> index 000000000000..385d317607c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/linux,current-from-voltage.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Current ADC from voltage ADC and resistor
>> +
>> +maintainers:
>> +  - Jonathan Bakker <xc-racer2@live.ca>
>> +
>> +properties:
>> +  compatible:
>> +    const: linux,current-from-voltage
> 
> How is an ADC with a resistor attached a Linux thing? So you don't need 
> 'linux', but then 'current-from-voltage' isn't the best naming. I don't 
> have a suggestion ATM.
> 

The good/bad news is that I was re-implementing an existing driver under a new name :)

The compatible is current-sense-shunt for this exact same purpose.

Thanks,
Jonathan

>> +
>> +  io-channel-names:
>> +    const: adc
>> +
>> +  io-channels:
>> +    maxItems: 1
>> +    description: Voltage ADC channel
>> +
>> +  linux,resistor-ohms:
>> +    description: Strength of resistor connected to voltage ADC
> 
> Wouldn't you need this to be micro-ohms? Otherwise, there'd be too much 
> voltage drop?
> 
> Rob
> 
