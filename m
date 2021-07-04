Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E074E3BAF2D
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhGDVU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 4 Jul 2021 17:20:57 -0400
Received: from aposti.net ([89.234.176.197]:48364 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhGDVU4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 17:20:56 -0400
Date:   Sun, 04 Jul 2021 22:18:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/2] Add "extended_name" to label
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <AIOQVQ.VCBVMZQG56T83@crapouillou.net>
In-Reply-To: <20210704183425.34df79ef@jic23-huawei>
References: <20210618123005.49867-1-paul@crapouillou.net>
        <20210704183425.34df79ef@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim., juil. 4 2021 at 18:34:25 +0100, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> On Fri, 18 Jun 2021 13:30:03 +0100
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  Hi Jonathan,
>> 
>>  This is the v3 of my patchset that sets the label attribute to the
>>  "extended_name".
>> 
>>  v3 only refactors the code of patch [2/2] to make it look a bit 
>> better.
> 
> Hi Paul,
> 
> Just thought I'd let you know v3 looks great to me.  Timing meant I 
> didn't
> manage to get it into last cycle, and am now waiting for rc1 to give 
> a nice
> place to rebase my trees on.  Hence I'll pick this up in a week or 
> two.

That's perfectly fine, I wasn't expecting it to land before rc1.

Cheers,
-Paul


