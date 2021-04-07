Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0532C356CE4
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhDGNG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 09:06:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2797 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhDGNG6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 09:06:58 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFl056PbTz687p4;
        Wed,  7 Apr 2021 21:01:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 7 Apr 2021 15:06:47 +0200
Received: from localhost (10.47.92.157) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 14:06:47 +0100
Date:   Wed, 7 Apr 2021 14:05:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: Add IIO trees to linux-next
Message-ID: <20210407140523.00004a70@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.157]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Stephen,

I would like to request adding the following two branches to linux-next.
Both normally merge through Greg's staging tree.

IIO fixes branch which merges through Greg's staging-linus branch.
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#fixes-togreg

IIO stuff for next merge window which merges through Greg's staging-next branch.
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#togreg

Both are the same as the staging trees today as Greg accepted
a pull request earlier today and I just rebased before sending this.

Thanks,

Jonathan
