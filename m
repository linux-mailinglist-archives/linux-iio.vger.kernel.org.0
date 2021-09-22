Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F5414501
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhIVJYD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 22 Sep 2021 05:24:03 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39415 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhIVJYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 05:24:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4EE051BF214;
        Wed, 22 Sep 2021 09:22:32 +0000 (UTC)
Date:   Wed, 22 Sep 2021 11:22:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: iio: Understanding the modes
Message-ID: <20210922112231.37e565e6@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello IIO folks,

I am currently writing a blog post trying to explain the situation that
I had with the max1027 driver [1] and possibly try to explain the logic
behind the changes that Jonathan/Nuno requested. As part of this work, I
tried to understand (and explain?) the meaning of the mode definitions
and if they were needed or not, but just looking at the code was not
enough for me to really understand.

While digging into the IIO core, I realized that many definitions and
helpers had no comments explaining their use. I could not find any
documentation about the kernel API in general neither (while the
userspace side is well documented).

I asked yesterday on #linux-iio but got no answers so I am also asking
here in case there are knowledgeable people willing to explain what
each of these definition actually mean and how they should be used:
https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio.h#L319

I am ready to send a patch upstream to add the necessary comment
so that these explanations do not stay on the mailing list only.

Thanks,
Miquèl

[1] https://lore.kernel.org/linux-iio/20210918180918.6908bbd9@jic23-huawei/
