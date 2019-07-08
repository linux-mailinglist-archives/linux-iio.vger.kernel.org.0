Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB261C6D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfGHJbS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jul 2019 05:31:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729035AbfGHJbS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jul 2019 05:31:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 35962C22F123AEC62D74;
        Mon,  8 Jul 2019 17:31:15 +0800 (CST)
Received: from localhost (10.227.98.71) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 17:31:13 +0800
Date:   Mon, 8 Jul 2019 17:31:05 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: Patch ping?
Message-ID: <20190708173105.00007834@huawei.com>
In-Reply-To: <MN2PR12MB337379F97BD39449A32DC2D8C4F60@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <MN2PR12MB337379F97BD39449A32DC2D8C4F60@MN2PR12MB3373.namprd12.prod.outlook.com>
Organization: Huawei R&D UK Ltd.
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.98.71]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Jul 2019 09:15:04 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> just a ping about my patch to add correct available scan masks to inv_mpu6050 driver.
> 
> Title is: [PATCH v2] iio: imu: mpu6050: add missing available scan masks
> 
> Thanks for your feedback.
> 
> Best regards,
> JB

Hi Jean-Baptiste,

That one just came in after sent my final pull request for the merge window
(which is now open).  I'm traveling at the moment, so for simple, obviously
correct patches I'm pretty much ignoring them as a delay at this stage makes
no difference (there is no path upstream until after the merge window has
closed) I'll get this particular one queued up as a fix one I'm back
home next week.

Thanks (and you were quite right to ping btw, I forgot to send out my
normal I'll be traveling email)

Jonathan

