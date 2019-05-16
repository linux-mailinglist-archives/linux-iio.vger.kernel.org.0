Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1920985
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEPO0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 10:26:48 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38785 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPO0r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 May 2019 10:26:47 -0400
Received: by mail-wr1-f48.google.com with SMTP id d18so3655522wrs.5
        for <linux-iio@vger.kernel.org>; Thu, 16 May 2019 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nRNl7486WAsnpDy7a+U5B0lu8x+sUgvErYJ6mV53FW8=;
        b=NzbwMq9MadWmbCkpTjc/7lhuJEyPdSIIQTegPPvyjqpIeGWn/vB4L2qv0e+FYuwYVT
         J5MJbdckTjEVeYMCYk9xFDzjlnBXdcG4bpuK/13QFqDcoNeo8k/FtxEhpNPjr/cArYol
         /PTFOdwBMpOr6NuVL8c6S99ApQFiZyfCvJc5bOd2gNMc5DniwyzuwgUBL0MtiTZU97D4
         GTPSgD1xTlcS5S/U3GLwE8klA8j5+g0/XsIZsy9gB4wqidM3HTla1Z4yHye4KS9Uadj6
         dA1m4M8HSIj9ZBDMUbsAHJz3Wvqx/sS+Rp24fI7DaUEaOHg9Sq6DWfIorhJ9NQedto7Y
         jryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nRNl7486WAsnpDy7a+U5B0lu8x+sUgvErYJ6mV53FW8=;
        b=OdHj/5WBmaJwcdwS4Nh5RBy5QHZyG7DS63PPWgvZ3SmT9Wl2Ryt6kV8opNTbtNM+/Q
         kuJgf9v4rF7yAjjkUMTyFzPLLjTxRMr2pgBIvuzJ0YBnqS0fjZs/W69Xo8ccfkf17YUH
         FQNK6zLTSHanURXz8miNQSq77UpZ0D/hsyhZuJR+OtoXU9BRRp5K9XNjUpFwIizywNLx
         XMaCHqqchod7vYTzzGgY2YSybAUFuZ78uLQUoa4Qgs+MEhPcmhJRJr/aL07yvnvQ1eyE
         3+SDBHGLTB06r99bWeiR8M5wiyctJnP6kgByA6+REDh76toR+GRfT/zMy32DO29/etoH
         aqtA==
X-Gm-Message-State: APjAAAUS4rJOJaFqB+l1BA/5lLvQog0eLUqNaFKWdakbxbL/PukAT+F9
        raa3K3L57wNeIj3ae0+zDpMCkHPDGIdpcKhyBtPwOq92nCw=
X-Google-Smtp-Source: APXvYqwv6Mnlqg1/t4F5DZ5tX9F5/raJ+y8Nqi2GWmwj009srmqqCABSFjX62CSngSTYbd/D/lGbg9trIQ4cVX252AU=
X-Received: by 2002:adf:dc0c:: with SMTP id t12mr17386694wri.101.1558016805666;
 Thu, 16 May 2019 07:26:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jean-Michel Hautbois <jhautbois@gmail.com>
Date:   Thu, 16 May 2019 16:26:34 +0200
Message-ID: <CAL8zT=hNLEDCkaBc9jugfQtoWpL_f89KZe3oqoKrVwgWb0Q9vg@mail.gmail.com>
Subject: AD7450 support
To:     linux-iio@vger.kernel.org, michael.hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi there,

I have an OMAP3 board on which an AD7450 is connected on the mcspi1 bus.
https://www.analog.com/media/en/technical-documentation/data-sheets/AD7450.pdf

From what I understand, this is a very simple one channel ADC, and I
suppose (looking for a confirmation :)) it could be added to the
ad7476 IIO driver ?

Thanks,
JM
