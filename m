Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC927A229C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIOPk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjIOPk0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 11:40:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E8F3
        for <linux-iio@vger.kernel.org>; Fri, 15 Sep 2023 08:40:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnJHp6CGPz6HJjk;
        Fri, 15 Sep 2023 23:38:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 16:40:19 +0100
Date:   Fri, 15 Sep 2023 16:40:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <Marius.Cristea@microchip.com>, <linux-iio@vger.kernel.org>
Subject: Re: [bug report] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230915164018.000004ff@Huawei.com>
In-Reply-To: <a1e72a3e-e4a7-4319-863c-28ac3b6fbe41@kadam.mountain>
References: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
        <b936e5cf-fcd3-421b-917a-5673df02f631@kadam.mountain>
        <2d35a8d374dfd68c9c85fab2ec552555b1343a09.camel@microchip.com>
        <a1e72a3e-e4a7-4319-863c-28ac3b6fbe41@kadam.mountain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Sep 2023 16:29:26 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Thu, Sep 14, 2023 at 01:19:33PM +0000, Marius.Cristea@microchip.com wrote:
> > Hello Dan Carpenter,
> > 
> > 
> >   Thank you for your feedback.
> > Indeed, it will not add more information in this case so sure I can
> > remove that line.
> > 
> > Please, tell me how it is best to procced next: submitting another
> > PATCH (V6) in this case, or to create a Fixes to the PATCH_V5?
> >   
> 
> I believe that you should send a follow on patch instead of sending
> another rev.
> 
> regards,
> dan carpenter
> 
> 
Yes - at this stage follow on patch preferred.

Jonathan
