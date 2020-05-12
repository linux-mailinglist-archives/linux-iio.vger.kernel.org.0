Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A431D1CF63C
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgELNze (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 09:55:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51185 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgELNze (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 09:55:34 -0400
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 80205240007;
        Tue, 12 May 2020 13:55:32 +0000 (UTC)
Message-ID: <16f4bfe1c254798291507aca00afeb2c8b0978a7.camel@hadess.net>
Subject: linux-iio and Windows default orientations
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-iio@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>
Date:   Tue, 12 May 2020 15:55:31 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,

I'm just dotting the is, and crossing the ts on a bunch of iio-sensor-
proxy documentation and wanted to revisit the IIO documentation,
compared to what Windows, and my implementation did.

Does this:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1638
in particular the "Z" axis:
"Z is perpendicular to the screen plane and positive out of the screen"

match this:
https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensor-orientation
"with the positive z-axis extending out from the device."

This Microsoft page didn't exist when I changed the code to "match
Windows 10" in 2016:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/commit/35b6328cbdaa5efa30917c445962d64fd733fb02

(And just to double check, it seems that the other 2 axis do match in
their definitions, right?)

Cheers

