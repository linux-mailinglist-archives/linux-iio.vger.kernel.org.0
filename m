Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B241F154E3F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 22:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBFVoq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 6 Feb 2020 16:44:46 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:51102 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFVoq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 16:44:46 -0500
Received: from [192.168.1.106] (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AC648251E0;
        Thu,  6 Feb 2020 22:44:42 +0100 (CET)
Date:   Thu, 06 Feb 2020 22:44:37 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Message-Id: <1581025477.790008.1@ixit.cz>
In-Reply-To: <CAL_JsqKQm7rnfm=QZSS+83czgaLoE6Wtg2se9r0ayvMgtfd-ZQ@mail.gmail.com>
References: <20200204093031.616409-1-david@ixit.cz>
        <20200204093031.616409-2-david@ixit.cz> <20200206190758.GA11064@bogus>
        <1581023799.790008.0@ixit.cz>
        <CAL_JsqKQm7rnfm=QZSS+83czgaLoE6Wtg2se9r0ayvMgtfd-ZQ@mail.gmail.com>
X-Mailer: geary/3.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org




Rob Herring <robh@kernel.org> napsal Čt, 6. úno 2020 v 14∶27:
> On Thu, Feb 6, 2020 at 2:16 PM David Heidelberg <david@ixit.cz> wrote:
>> 
>> 
>> 
>> 
>>  Rob Herring <robh@kernel.org> napsal Čt, 6. úno 2020 v 19∶07:
>>  > On Tue, Feb 04, 2020 at 10:30:27AM +0100, David Heidelberg wrote:
>>  >>  This commit add dt-bindings support to al3320a driver and
>>  >> vendor-prefix
>>  >>  dynaimage.
>>  >>
>>  >>
>>  >>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  >>  ---
>>  >>   .../bindings/iio/light/al3320a.yaml           | 45
>>  >> +++++++++++++++++++
>>  >>   .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>  >>   2 files changed, 47 insertions(+)
>>  >>   create mode 100644
>>  >> Documentation/devicetree/bindings/iio/light/al3320a.yaml
>>  >>
>>  >>  diff --git
>>  >> a/Documentation/devicetree/bindings/iio/light/al3320a.yaml
>>  >> b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
>>  >>  new file mode 100644
>>  >>  index 000000000000..08e7ee4bdf55
>>  >>  --- /dev/null
>>  >>  +++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
>>  >>  @@ -0,0 +1,45 @@
>>  >>  +# SPDX-License-Identifier: (GPL-2.0-only)
>>  >
>>  > Dual license new bindings:
>>  >
>>  > (GPL-2.0-only OR BSD-2-Clause)
>> 
>>  It BSD usage in Linux kernel enforced for bindings?
> 
> Yes, bindings are exported and used by other projects. And may get
> moved out completely.

So do I assume right if I'm not dual licencing also under BSD, patch 
won't get merged?

By principle I don't like to being forced give my work to projects 
which don't comply with GPL 2. Not much happy about it, but what can I 
do, when I want this sensors DT merged in...

Due to the fact it's simple definition, I'll dual licence it also to 
BSD for next patch version.

>> 
>>  I'd like to publish my code only under GPL if possible.


