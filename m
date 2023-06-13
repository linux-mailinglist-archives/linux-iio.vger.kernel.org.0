Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487E72DFB9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jun 2023 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbjFMKhy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jun 2023 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjFMKhq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 06:37:46 -0400
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D394
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 03:37:43 -0700 (PDT)
Received: from [140.78.146.150] (unknown [140.78.146.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4QgQ440wkkz2PRB;
        Tue, 13 Jun 2023 12:37:40 +0200 (CEST)
Message-ID: <1068e94915d6512b2acd73a8a930c91538c9de8b.camel@jku.at>
Subject: Re: Questions about ad5933 driver
From:   David Schiller <david.schiller@jku.at>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org
Date:   Tue, 13 Jun 2023 12:37:39 +0200
In-Reply-To: <20230607155224.000001d0@Huawei.com>
References: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
         <20230606113013.00000530@Huawei.com>
         <1204b19a92343a9e3a6ec5df3cef94f6777e08c4.camel@jku.at>
         <20230607155224.000001d0@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2023-06-07 at 15:52 +0100, Jonathan Cameron wrote:
> Not 'official' though it is fairly commonly used, but the documented
> ABI in
> Documentation/ABI/testing/sysfs-bus-iio*
> is and these aren't there either.
> 
> I'm not 100% sure this is the right way to solve this ABI gap though
> so need to have a bit of a think about it.  Using a modifier means we
> can't
> use them for anything else, so need to consider if there are other
> modifiers
> (or it has meaning for differential channels) when deciding if this is
> an ABI we want to add.

The naming of the modifiers is also somewhat confusing. The HW registers
represent the DFT of the input signal, which together with a gain factor
is used to calculate the impedance. Dimensionally the quantities are
admittances. "voltage_real" and "voltage_imag" are therefore not quite
fitting.

Also the sweep setup commands are only run once per buffer (in
ad5933_ring_preenable). This means a buffer can only be used for one
sweep and then has to be disabled and enabled again. As the driver does
not implement any triggers this is right now the only way to start a
measurement.

Do you think it would make sense to implement a user-space trigger to
start a measurement sweep? This would mean that a buffer can be reused.
Right now the "iio_readdev" test program from libiio does not work due
to this behavior. I don't know how this is handled on other IIO drivers.

Lastly, should I CC the original author (Michael Hennerich) going
forward?

Thanks!


