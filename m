Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52863723C3D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjFFIxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjFFIxq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 04:53:46 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 01:53:44 PDT
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413F8F
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 01:53:44 -0700 (PDT)
Received: from [140.78.146.150] (unknown [140.78.146.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4Qb3wk271xz2PQ1
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 10:46:14 +0200 (CEST)
Message-ID: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
Subject: Questions about ad5933 driver
From:   David Schiller <david.schiller@jku.at>
To:     linux-iio@vger.kernel.org
Date:   Tue, 06 Jun 2023 10:46:14 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

I attempted to use the ad5933 impedance analyzer driver in combination
with libiio.

Trying to enumerate the local devices with "iio_info" leads to an error,
which I traced down to the naming of the in_voltage_{real,imag}_* sysfs
scan_elements nodes. The name modifiers "real" and "imag" are not valid
sysfs symbols, it seems.
The driver is in the staging directory, so I don't know if it has to
conform to the general IIO sysfs ABI.

I worked around this by patching libiio, but I don't know if that's the
correct approach.

What do you think?

Best regards
David

