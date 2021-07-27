Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B253D7E6A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhG0TU2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 27 Jul 2021 15:20:28 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37844 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhG0TUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 15:20:25 -0400
Received: by mail-wr1-f52.google.com with SMTP id l4so16441986wrs.4
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 12:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=avk7IuAa6fSD+99UB8FgBzV3nkJYhbaantOZrJM7o5c=;
        b=G2gxZ+dcAPEmP2DU76UkuCw467AguLQ8AjUakLWslXzR6jLX9ejOf2RAH/phNUJeuB
         tmW/XFhpyYmw0EiHoOoXxrfH3+GQtLUDLBkMejNnHGBjPKJdR8a/0xQMHKzuqvhHVFZa
         OQkSMDoERvTmTgopmo6H55i63fRnRhYryBuCaK3aXSOMrLQPWGkPh5XQWpaW/PAJyv26
         NZo9xTc7GH2s7jjlj7bSOlcJciMF7vFWE0YB7lifT9pXmtJuw5PbYpb360t57gaJuJLj
         DP5wIi8nDbxv93dZqvJ0JqjYVRhHpg6z8sElBR2TPY4R6IZ5wf6nrceA/u7V10Yfgb9G
         +aVQ==
X-Gm-Message-State: AOAM5315NijpGy/6QJFFyZ44zsIbZ5Gnkgj97299urzuEceSoeBOA1fo
        kjLi5erHfLDrqWXlcyiuYsMEmuqGDds=
X-Google-Smtp-Source: ABdhPJzoRzdsyvKISWqp9faQ1gnYThAh9Fv6YatuAvmynyHtew2nz+CI4acigfACbLxKLC8+j6LQLQ==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr2930529wrs.365.1627413622416;
        Tue, 27 Jul 2021 12:20:22 -0700 (PDT)
Received: from localhost.localdomain (cpc142184-mcam2-2-0-cust140.18-3.cable.virginm.net. [82.31.129.141])
        by smtp.gmail.com with ESMTPSA id x8sm4262568wrt.93.2021.07.27.12.20.21
        for <linux-iio@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jul 2021 12:20:22 -0700 (PDT)
Received: from smtpclient.apple ([10.0.0.191])
        by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id 16RJ091E012847
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 20:00:10 +0100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
From:   Patrick Regnouf <patrick@patricknet.net>
Mime-Version: 1.0 (1.0)
Date:   Tue, 27 Jul 2021 20:20:15 +0100
Subject: Seeking documentation
Message-Id: <48BB2335-FCEE-44F0-B771-02D065F3C54C@patricknet.net>
To:     linux-iio@vger.kernel.org
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

New to libiio and cannot find any documentation and much less sample C programs to assign IRQ produced by an accelerometer to a user space program

In other words I need to write a daemon whose task is to be awaken by an IRQ (42 in my case) and write the event in a log file

I have already written code in that daemon that can  enumerate devices in the context and list channels etc..

I would really like to find sample C code that assign an IRQ to a device and basically is called in a function by the kernel. 

/Patrick
