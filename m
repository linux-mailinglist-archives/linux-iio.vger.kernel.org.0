Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209AF47892B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 11:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhLQKqj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 05:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLQKqj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 05:46:39 -0500
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359AC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 02:46:38 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 81F9560047
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 10:46:35 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1639737994;
        bh=kkx6E/nQHvtw1lgzAJ+yCdf2vOmL/7z3wQRsDr+Gp9E=;
        h=To:From:Subject:Date:From;
        b=RR6+gDV2wymdXzAny5EeeA4nOZYgP4fJhmZTBks19Y9dIU0UPAhmbkbgf/3bSp/8o
         y2cm/ZxqPj+RzdYjHFDCkEH/AfwL6128uhcPN477Pmz5aY5oMoULtoCMNp2vAH6oy/
         W80+IzSf9lV+Kfy5NdtuclZRUBdFB52a1mMNcx8D64vcvC8+6DsqwNOWAOZcWh22Xs
         +Q3v8Mkq+O93IxU11xhRdj2XDf1O7SRoqs+t8AMiE+rP+kaluNvaaYiQ9nm+8T/mRA
         RlAuNIAaPQYTZSmPPRYmMIg98+vgJB9V+TpVzfuf7trGoBhsgi4tmKCCehyOdYau7z
         QqGW7Auh/AICg==
To:     linux-iio@vger.kernel.org
From:   Henk Medenblik <yoda@deathstar2.nl>
Subject: iio_hwmon meaningful names
Organization: DeathStar2
Message-ID: <e723786f-abd2-86ac-7eb8-f5e92c63b31c@deathstar2.nl>
Date:   Fri, 17 Dec 2021 11:46:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Did anyone ever asked for meaningful names for the iio-hwmon readout?
I integrated the Xilinx AMS block which now shows up  through the 
sensors readout as:

iio_hwmon-isa-0000
Adapter: ISA adapter
in1:           1.19 V
in2:         357.00 mV
in3:         860.00 mV
in4:         859.00 mV
in5:           1.78 V
in6:           1.78 V
in7:         842.00 mV
temp1:        +45.0 C
temp2:        +44.4 C
temp3:       -280.2 C

But I believe an option to make more sense of in1 - in7 and temp1-temp3 
would be a nice addition.

Henk

