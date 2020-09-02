Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12925B41F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIBSyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 14:54:09 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:53912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgIBSyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 14:54:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4C4C2180A7FFE;
        Wed,  2 Sep 2020 18:54:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:4659:5007:6119:6121:7514:7807:7974:9025:9388:9389:10004:10049:10400:10848:11232:11657:11658:11914:12043:12295:12297:12555:12740:12760:12895:13200:13229:13255:13439:14096:14097:14106:14181:14659:14721:14849:21080:21324:21325:21433:21611:21627:21691:21781:21819:21939:30003:30054:30056:30060:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: base04_3201bb5270a3
X-Filterd-Recvd-Size: 4503
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Sep 2020 18:54:05 +0000 (UTC)
Message-ID: <c481fb32b071c02fe21fe669c0e67117b16386dd.camel@perches.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Sep 2020 11:54:04 -0700
In-Reply-To: <CAHp75Vd3sT6Vuovsy8YQg+pdqQd3s4vU8PQNNQvUruKZOiRSAw@mail.gmail.com>
References: <20200902145957.13861-1-krzk@kernel.org>
         <CAHp75Vd3sT6Vuovsy8YQg+pdqQd3s4vU8PQNNQvUruKZOiRSAw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-09-02 at 21:11 +0300, Andy Shevchenko wrote:
> On Wed, Sep 2, 2020 at 6:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Emails to Beniamin Bia bounce with no such address so remove him from
> > maintainers.  After this removal, many entries for Analog Devices Inc
> > IIO drivers look exactly the same so consolidate them.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> But nit-pick below.
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -1152,8 +1101,12 @@ W:       http://wiki.analog.com/
> >  W:     http://ez.analog.com/community/linux-device-drivers
> >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> > +F:     Documentation/devicetree/bindings/iio/adc/adi*
> > +F:     Documentation/devicetree/bindings/iio/amplifiers/adi*
> 
> I would rather see one line like
> F:     Documentation/devicetree/bindings/iio/*/adi,*

Maybe the ones outside of iio too?

$ find Documentation/ -wholename "*/adi,*"
Documentation/devicetree/bindings/net/adi,adin.yaml
Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
Documentation/devicetree/bindings/sound/adi,adau7002.txt
Documentation/devicetree/bindings/sound/adi,adau1977.txt
Documentation/devicetree/bindings/sound/adi,adau7118.yaml
Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
Documentation/devicetree/bindings/sound/adi,adau17x1.txt
Documentation/devicetree/bindings/sound/adi,ssm2305.txt
Documentation/devicetree/bindings/sound/adi,adau1701.txt
Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
Documentation/devicetree/bindings/sound/adi,ssm2602.txt
Documentation/devicetree/bindings/mux/adi,adgs1408.txt
Documentation/devicetree/bindings/mux/adi,adg792a.txt
Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml


