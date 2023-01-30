Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8D68173F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjA3RJ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 12:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3RJ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 12:09:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA83FF2B;
        Mon, 30 Jan 2023 09:09:26 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5F4p1T6vz6J9gC;
        Tue, 31 Jan 2023 01:08:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 17:09:24 +0000
Date:   Mon, 30 Jan 2023 17:09:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: iio: accel: Add ADIS16203
 Inclinometer
Message-ID: <20230130170923.00000752@Huawei.com>
In-Reply-To: <20230130152137.GA2586655-robh@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
        <20230129155602.740743-13-jic23@kernel.org>
        <167502679603.787347.16663590794832817182.robh@kernel.org>
        <20230130152137.GA2586655-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 09:21:37 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jan 30, 2023 at 07:35:26AM -0600, Rob Herring wrote:
> > 
> > On Sun, 29 Jan 2023 15:56:02 +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > There has been a driver in staging for quite a while.
> > > Given we are now moving it to the main tree, time to make sure it
> > > has binding documentation.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > --
> > > V2:
> > > - maxItems/minItems added where needed.
> > > - fix interrupt-names to allow multiple entries.
> > > ---
> > >  .../bindings/iio/accel/adi,adis16203.yaml     | 64 +++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >   
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.example.dtb: accelerometer@0: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml  
> 
> I was scratching my head on this one... Check the compatible string in 
> the example. You've got 201 instead of 203.
> 
> Are these parts that different?
> 
> Rob

Gah,  Not sure why I didn't see this error - definitely something odd going on when
I test at the moment. The parts are not particularly related.

I'll fix that and send a v3. 
 
