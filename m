Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5004144B2AF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhKISYm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 13:24:42 -0500
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:52236 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242269AbhKISYj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 13:24:39 -0500
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DA2FC7254D;
        Tue,  9 Nov 2021 18:21:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id ED2D9D1515;
        Tue,  9 Nov 2021 18:21:47 +0000 (UTC)
Message-ID: <80960e445c986408e4ae9a20ac42c5b66d4d8046.camel@perches.com>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, andrea.merello@gmail.com,
        Andi Kleen <ak@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Date:   Tue, 09 Nov 2021 10:21:46 -0800
In-Reply-To: <021c6fe0-8131-a4f9-9cb0-2f4771d35da1@infradead.org>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
         <20211028101840.24632-1-andrea.merello@gmail.com>
         <20211028101840.24632-11-andrea.merello@gmail.com>
         <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
         <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
         <021c6fe0-8131-a4f9-9cb0-2f4771d35da1@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: twcqu5gfawgudegsek9dxu71sby3ankr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: ED2D9D1515
X-Spam-Status: No, score=-3.40
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Z3362bnutoA4iFYG1yfO0L9S/2elaolI=
X-HE-Tag: 1636482107-201099
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(cc'ing Andi Kleen, who wrote this code a decade ago)

On Tue, 2021-11-09 at 07:47 -0800, Randy Dunlap wrote:
> On 11/9/21 3:56 AM, Andrea Merello wrote:
> > Il giorno ven 29 ott 2021 alle ore 00:04 Randy Dunlap <rdunlap@infradead.org> ha scritto:
> > > On 10/28/21 3:18 AM, Andrea Merello wrote:
> > > > This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
> > > > and it enables the BNO055 core driver to work in this scenario.
> > > > 
> > > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > > > ---
> > > >    drivers/iio/imu/bno055/Kconfig      |  6 ++++
> > > >    drivers/iio/imu/bno055/Makefile     |  1 +
[]
> > > > diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
[]
> > > > @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
> > > >        tristate "Bosh BNO055 attached via serial bus"
> > > >        depends on SERIAL_DEV_BUS
> > > >        select BOSH_BNO055_IIO
> > > > +
> > > > +config BOSH_BNO055_I2C
> > > > +     tristate "Bosh BNO055 attached via I2C bus"
> > > > +     depends on I2C
> > > > +     select REGMAP_I2C
> > > > +     select BOSH_BNO055_IIO
[]
> > > The config entries that have user prompt strings should also
> > > have help text.  scripts/checkpatch.pl should have told you
> > > about that...
> > 
> > I'll add it, thanks. But FYI checkpatch doesn't complain about that here.
> 
> Hm, thanks for adding it and telling me about that.
> 
> checkpatch.pl does have some code for checking that but I confirmed
> that it does not catch this simple case.
> 
> Joe, can you identify why checkpatch does not detect missing Kconfig
> help text is this simple case?

Original patch here: https://lore.kernel.org/all/20211028101840.24632-11-andrea.merello@gmail.com/raw

checkpatch is counting the diff header lines that follow the config entry.
Maybe this is clearer (better?) code:
---
 scripts/checkpatch.pl | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1784921c645da..b3ce8e04d7df7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3483,20 +3483,22 @@ sub process {
 			my $cnt = $realcnt;
 			my $ln = $linenr + 1;
 			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
+			my $needs_help = 0;
+			my $has_help = 0;
 			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
 				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+				$cnt-- if ($f !~ /^-/);
 
 				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+				last if (!$file && $f =~ /^(?:\@\@|diff )/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+					$needs_help = 1;
+					next;
+				} elsif ($f =~ /^\+\s*help\s*$/) {
+					$length = 0;
+					$has_help = 1;
+					next;
 				}
 
 				$f =~ s/^.//;
@@ -3510,16 +3512,16 @@ sub process {
 				# common words in help texts
 				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
 						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
 					last;
 				}
-				$length++;
+				$length++ if ($has_help);
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($needs_help &&
+			    (!$has_help ||
+			     ($has_help && $length < $min_conf_desc_length))) {
 				WARN("CONFIG_DESCRIPTION",
 				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
 # check MAINTAINERS entries


