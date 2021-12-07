Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C148446BBA4
	for <lists+linux-iio@lfdr.de>; Tue,  7 Dec 2021 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhLGMva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhLGMv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 07:51:29 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Dec 2021 04:47:58 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959FC061746
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 04:47:58 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 7B1ED6027F
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 12:40:23 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1638880822;
        bh=hfvrq+5uOSoyXGXvE+oiMGZBQfbegdAjsVKCc7l2NcM=;
        h=To:From:Subject:Date:From;
        b=O8uloR5Sm3ZVUrijeg+uAEGMyFjRgYDVnkPuGce8AB6MqgfMGL3e+w153dJrIz9da
         7L8uwSTOKqTzwWp6/YAgmqyzVK5H0UxOD4ehtAeiOFmlMYIWDDlCxDgE2KFKuK9b35
         2cDyfvo3DXWiAbH8xop1d3vI92KWJ7d54g9G0Igb258xXsl3+2d3ZsekdW/U7ZtHFm
         MrXrt14EtkymU7yZRkLzwkS/saT5p7bVCrJUBRovYExcSvNws5UT5VItJRYw9ScLRZ
         xLk1LuZyKXX94LhjMO/52H7l6yKL5IvlAEn6ITkC/EQK+GsjYQ6nUscfArJhjbH7/b
         atYq/oVnWUlbw==
To:     linux-iio <linux-iio@vger.kernel.org>
From:   Henk <yoda@deathstar2.nl>
Subject: iio display large numbers
Organization: DeathStar2
Message-ID: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
Date:   Tue, 7 Dec 2021 13:40:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I derived the LTC6951 driver from an existing analog devices LTC6952 driver.
However for my situation this clock synthesis/buffer uses quite large 
output frequencies (2.5GHz) which does not fit in the IIO_VAL_INT size 
when retrieved with iio_info.

I wonder if there is a way to represent such long integers within the 
iio_framework. I believe currently there isn't right?

Regards,

Henk

-- 
“Do. Or do not. There is no try.”...

