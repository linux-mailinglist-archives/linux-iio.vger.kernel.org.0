Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07A21A6445
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgDMIi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 04:38:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44531 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgDMIip (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 04:38:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id o25so6839034oic.11
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=fnwVMzJrohE+7ilrPi2N1KFN9138i0bSO8Z2MuXC60Y=;
        b=Sn0w6lD3fYeaIaCm4TCHLL7EJSBtkhitWyKBmocYhAPKkwr78BpNOGRwJcchS6dX1g
         gHQheIL2Sj0dLv2ywymH/OE9BHbohP6HdvKDQ1Uda45Xke3nZiaIolrLyYYf7j36sPZt
         jf1UAqZHZdXFrKxNyOp9Qex9bSuX3+sNm6uPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fnwVMzJrohE+7ilrPi2N1KFN9138i0bSO8Z2MuXC60Y=;
        b=l4XfSDou9FM4dv9rJKBkd9qeUGSiUvVwHLdv5EYAhjOoKLJpPkrDXlh2ajVf2Q+Cww
         PYM1qCOPHuWZEu59Md6q61Eg00p2a546yZShUnYp/WB+JW/0KFheLJrcq7Z9HD8Y/4oJ
         0H4lTIKn2RtjVSSg1432txvAeiEM6fenp10pGxoG/ubDVAjmv6iulK9NzRW/8ofdFQuk
         4902odkQBNDWx2ngDLh60rsuRToJFR21nPfHUsZ8wn5VtIKBtqm2ZA5McDj7OUPZpACC
         nuBVAAN0dEyXKDw8dcQUVBfe8PfzHWh0qIEFky9uSQGnWGtl3QEGd8n/C0fPcRr2mmqT
         LAGw==
X-Gm-Message-State: AGi0Publ35NHEAFeS+JWvvNBRndBg/KIuVkJc+MYSf1RqmXtON0X/QK+
        K1frio/cVQeqkAUxo59z4HW+Z+N/wEsiAf2TTwmF0nDByMAT/g==
X-Google-Smtp-Source: APiQypIUE54hiWwKOAS9VOngjFl81gtTl29B7N0MIvl/VzbLEIZjebKbY8MkicenwKId2vc4dTA+6H6Z6zvCvxG700A=
X-Received: by 2002:aca:d705:: with SMTP id o5mr11399083oig.67.1586767124388;
 Mon, 13 Apr 2020 01:38:44 -0700 (PDT)
MIME-Version: 1.0
From:   Lars Engebretsen <lars@engebretsen.ch>
Date:   Mon, 13 Apr 2020 10:38:33 +0200
Message-ID: <CA+XPV5MX1aH3yMcRmukmOU4cPFL34dFfPoznwxGT6cTeqYSTvg@mail.gmail.com>
Subject: Small error in iio/iio.h
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

I just came across a small thing: I think that there is an erroneous
semicolon at the end of line 603 in include/linux/iio/iio.h

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/iio/iio.h?h=v5.7-rc1#n602

I'm completely new to kernel development, so I don't know the process for
submitting patches. Moreover, the macro seems to be gone in git://
git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git so maybe the issue
has been fixed already? In any case, I'd be happy to submit a patch if that
is the right thing to do. But then I'd need a bit of help to get started.

Thanks,
Lars
