Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFB59078C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Aug 2022 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiHKUtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Aug 2022 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKUtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Aug 2022 16:49:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD598A78
        for <linux-iio@vger.kernel.org>; Thu, 11 Aug 2022 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660250946; x=1691786946;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ueeb7xMUMASfpaC9OiUWcOiijyMprWbnLWAuNy3l/nc=;
  b=NTmrIYAPu2ZT1QZjMVhUP/iD7KMaUqKjmR6NyVhwkXF7Yb8MRD0b2jZ3
   ziqGnAWBRnlcgZjHOkgtWehqzyjZhqezJZBwMHdliyg5SBIudp1i7ck2F
   0G6LBZCUkOnYPzguyxjimZWBm5sZvWm055DzlvDqhxRLUf64Lih3MgAxh
   Wi9UbDwjS4PHrKLyId+n7JZDvbwHwRjdJUQ303PctN5WzGfEbm9csWt4V
   BBARNB+wMDlm58vrzd0KSh+0s8NxmEA8u6S51yydK3dvsa6pQpXltJfjP
   m5bnK+Sv5KDTkpKoNR2LXY3db6jaNNp8dZRnXmbTZNaP+7wXRcCK5MrJM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292252650"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="292252650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:49:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="556284694"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:49:06 -0700
Message-ID: <f3c95d3355d84562e37252a7313ba183eb219b53.camel@linux.intel.com>
Subject: Re: PROBLEM: Some intel-ish/hid-sensor-hub IIO devices always
 report 0 on synchronous read
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Even Xu <even.xu@intel.com>
Cc:     linux-iio@vger.kernel.org
Date:   Thu, 11 Aug 2022 13:49:06 -0700
In-Reply-To: <trinity-22d7d0e8-17b9-4b9b-a299-702c061ce8b8-1660243419946@3c-app-gmx-bs58>
References: <trinity-22d7d0e8-17b9-4b9b-a299-702c061ce8b8-1660243419946@3c-app-gmx-bs58>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2022-08-11 at 20:43 +0200, Philipp Jungkamp wrote:
> 
> [1.] One line summary of the problem:
> Some intel-ish/hid-sensor-hub IIO devices always report 0 on
> synchronous read

Try this:

/sys/bus/platform/device/HID-SENSOR-2000e1.*

cd power

echo on > control


Thanks,
Srinivas
> 
> [2.] Full description of the problem/report:
> Reading from some of the IIO sensor devices using the sysfs
> attributes does
> almost always report 0. This occurs on custom sensor drivers like
> hid-sensor-custom-intel-hinge or hid-sensor-custom. The Lenovo Yoga 9
> 14IAP7
> has several custom sensors, among them the intel hinge, an ambient
> light
> sensor, human presence detection and similar which are affected.
> But enabling the IIO buffer on the hinge or using the enable_sensor
> sysfs
> attribute on the custom sensor reports valid data in /dev.
> 
> [3.] Keywords:
> iio, ishtp, hid-sensor-hub, hid-sensor-custom
> 
> [4.1.] Kernel version:
> Linux version 5.19.0
> 
> [7.] A small shell script or example program which triggers the
> problem
> 
> # read hinge iio sensor through sysfs
> $ cat /sys/bus/iio/devices/iio:device1/in_angl0_raw
> 0
> 
> # enable the iio buffer for the hinge sensor
> $ echo 1 | tee
> /sys/bus/iio/devices/iio:device1/buffer0/{in_angl0_en,enable}
> 1
> 
> # read data from /dev until interrupted whil moving the hinge
> #
> # this shows the angle in degrees as ascii (~100 degrees) and
> # is pretty accurate and responsive on movement
> $ cat /dev/iio:device1
> }}||yyvvuussqqppmmllkkjjhijikkllkkllmmnnpprrppoooppppopppopppopppoppp
> opp
> 
> [8.5.] PCI information ('lspci -vvv' as root)
> 
> 00:00.0 Host bridge: Intel Corporation Device 4621 (rev 02)
> Subsystem: Lenovo Device 3802
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> IOMMU group: 0
> Capabilities: [e0] Vendor Specific Information: Len=14 <?>
> Kernel driver in use: igen6_edac
> Kernel modules: igen6_edac
> 
> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P
> Integrated Graphics Controller (rev 0c) (prog-if 00 [VGA controller])
> Subsystem: Lenovo Device 3804
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 125
> IOMMU group: 1
> Region 0: Memory at 601c000000 (64-bit, non-prefetchable) [size=16M]
> Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
> Region 4: I/O ports at 3000 [size=64]
> Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
> Capabilities: [40] Vendor Specific Information: Len=0c <?>
> Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI
> 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+ FLReset+
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
> 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
> 10BitTagReq- OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit-
> Address: fee00018 Data: 0000
> Masking: 00000000 Pending: 00000000
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Process Address Space ID (PASID)
> PASIDCap: Exec- Priv-, Max PASID Width: 14
> PASIDCtl: Enable- Exec- Priv-
> Capabilities: [200 v1] Address Translation Service (ATS)
> ATSCap: Invalidate Queue Depth: 00
> ATSCtl: Enable-, Smallest Translation Unit: 00
> Capabilities: [300 v1] Page Request Interface (PRI)
> PRICtl: Enable- Reset-
> PRISta: RF- UPRGI- Stopped+
> Page Request Capacity: 00008000, Page Request Allocation: 00000000
> Capabilities: [320 v1] Single Root I/O Virtualization (SR-IOV)
> IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
> IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy- 10BitTagReq-
> IOVSta: Migration-
> Initial VFs: 7, Total VFs: 7, Number of VFs: 0, Function Dependency
> Link: 00
> VF offset: 1, stride: 1, Device ID: 46a6
> Supported Page Size: 00000553, System Page Size: 00000001
> Region 0: Memory at 0000004010000000 (64-bit, non-prefetchable)
> Region 2: Memory at 0000004020000000 (64-bit, prefetchable)
> VF Migration: offset: 00000000, BIR: 0
> Kernel driver in use: i915
> Kernel modules: i915
> 
> 00:04.0 Signal processing controller: Intel Corporation Alder Lake
> Innovation Platform Framework Processor Participant (rev 02)
> Subsystem: Lenovo Device 3801
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 145
> IOMMU group: 2
> Region 0: Memory at 601d180000 (64-bit, non-prefetchable) [size=128K]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00538 Data: 0000
> Capabilities: [d0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: proc_thermal_pci
> Kernel modules: processor_thermal_device_pci
> 
> 00:06.0 PCI bridge: Intel Corporation 12th Gen Core Processor PCI
> Express x4 Controller #0 (rev 02) (prog-if 00 [Normal decode])
> Subsystem: Intel Corporation Device 7270
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin D routed to IRQ 122
> IOMMU group: 3
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: f000-0fff [disabled] [16-bit]
> Memory behind bridge: 5e200000-5e2fffff [size=1M] [32-bit]
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> [disabled] [64-bit]
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 256 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> LnkCap: Port #5, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1
> <16us
> ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 16GT/s, Width x4
> TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #0, PowerLimit 75W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState+
> RootCap: CRSVisible-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
> AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+
> 10BitTagReq- OBFF Disabled, ARIFwd+
> AtomicOpsCtl: ReqEn+ EgressBlck+
> LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
> LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
> EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00218 Data: 0000
> Capabilities: [90] Subsystem: Intel Corporation Device 7270
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap-
> ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> RootCmd: CERptEn- NFERptEn- FERptEn-
> RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> Capabilities: [220 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
> PortCommonModeRestoreTime=110us PortTPowerOnTime=500us
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> T_CommonMode=110us LTR1.2_Threshold=589824ns
> L1SubCtl2: T_PwrOn=500us
> Capabilities: [150 v1] Precision Time Measurement
> PTMCap: Requester:- Responder:+ Root:+
> PTMClockGranularity: 4ns
> PTMControl: Enabled:+ RootSelected:+
> PTMEffectiveGranularity: Unknown
> Capabilities: [a30 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [a90 v1] Data Link Feature <?>
> Capabilities: [a9c v1] Physical Layer 16.0 GT/s <?>
> Capabilities: [edc v1] Lane Margining at the Receiver <?>
> Kernel driver in use: pcieport
> 
> 00:07.0 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI
> Express Root Port #0 (rev 02) (prog-if 00 [Normal decode])
> Subsystem: Intel Corporation Device 7270
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 123
> IOMMU group: 4
> Bus: primary=00, secondary=02, subordinate=2a, sec-latency=0
> I/O behind bridge: 4000-4fff [size=4K] [16-bit]
> Memory behind bridge: 60000000-6c1fffff [size=194M] [32-bit]
> Prefetchable memory behind bridge: 6000000000-601bffffff [size=448M]
> [32-bit]
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> LnkCap: Port #2, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1
> <16us
> ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #3, PowerLimit 0W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+
> LinkChg+
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCap: CRSVisible-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
> AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
> 10BitTagReq- OBFF Disabled, ARIFwd-
> AtomicOpsCtl: ReqEn- EgressBlck-
> LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer-
> 2Retimers- DRS-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
> EqualizationPhase1-
> EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00258 Data: 0000
> Capabilities: [90] Subsystem: Intel Corporation Device 7270
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap-
> ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> RootCmd: CERptEn- NFERptEn- FERptEn-
> RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> Capabilities: [220 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> ACSCtl: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> Capabilities: [150 v1] Precision Time Measurement
> PTMCap: Requester:- Responder:+ Root:+
> PTMClockGranularity: 4ns
> PTMControl: Enabled:+ RootSelected:+
> PTMEffectiveGranularity: Unknown
> Capabilities: [a00 v1] Downstream Port Containment
> DpcCap: INT Msg #0, RPExt+ PoisonedTLP- SwTrigger- RP PIO Log 0,
> DL_ActiveErr-
> DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger-
> DL_ActiveErr-
> DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO
> ErrPtr:1f
> Source: 0000
> Capabilities: [a30 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [a90 v1] Data Link Feature <?>
> Capabilities: [ba0 v0] Physical Resizable BAR
> <error in resizable BAR: num_bars=0 is out of specification>
> Kernel driver in use: pcieport
> 
> 00:07.1 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI
> Express Root Port #1 (rev 02) (prog-if 00 [Normal decode])
> Subsystem: Intel Corporation Device 7270
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin B routed to IRQ 124
> IOMMU group: 5
> Bus: primary=00, secondary=2b, subordinate=53, sec-latency=0
> I/O behind bridge: 5000-5fff [size=4K] [16-bit]
> Memory behind bridge: 52000000-5e1fffff [size=194M] [32-bit]
> Prefetchable memory behind bridge: 6020000000-603bffffff [size=448M]
> [32-bit]
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> LnkCap: Port #3, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1
> <16us
> ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #4, PowerLimit 0W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+
> LinkChg+
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCap: CRSVisible-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
> AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
> 10BitTagReq- OBFF Disabled, ARIFwd-
> AtomicOpsCtl: ReqEn- EgressBlck-
> LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer-
> 2Retimers- DRS-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
> EqualizationPhase1-
> EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00298 Data: 0000
> Capabilities: [90] Subsystem: Intel Corporation Device 7270
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap-
> ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> RootCmd: CERptEn- NFERptEn- FERptEn-
> RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> Capabilities: [220 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> ACSCtl: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> Capabilities: [150 v1] Precision Time Measurement
> PTMCap: Requester:- Responder:+ Root:+
> PTMClockGranularity: 4ns
> PTMControl: Enabled:+ RootSelected:+
> PTMEffectiveGranularity: Unknown
> Capabilities: [a00 v1] Downstream Port Containment
> DpcCap: INT Msg #0, RPExt+ PoisonedTLP- SwTrigger- RP PIO Log 0,
> DL_ActiveErr-
> DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger-
> DL_ActiveErr-
> DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO
> ErrPtr:1f
> Source: 0000
> Capabilities: [a30 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [a90 v1] Data Link Feature <?>
> Capabilities: [ba0 v0] Physical Resizable BAR
> <error in resizable BAR: num_bars=0 is out of specification>
> Kernel driver in use: pcieport
> 
> 00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor
> Gaussian & Neural Accelerator (rev 02)
> Subsystem: Lenovo Device 3801
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 255
> IOMMU group: 6
> Region 0: Memory at 601d1db000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000 Data: 0000
> Capabilities: [a0] Vendor Specific Information: Len=14 <?>
> Capabilities: [dc] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [f0] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> 
> 00:0a.0 Signal processing controller: Intel Corporation Platform
> Monitoring Technology (rev 01)
> Subsystem: Lenovo Device 3801
> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> IOMMU group: 7
> Region 0: Memory at 601d1c0000 (64-bit, non-prefetchable) [size=32K]
> Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI
> 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag+ RBE- FLReset-
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
> 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
> 10BitTagReq- OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> Capabilities: [d0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Designated Vendor-Specific: Vendor=8086
> ID=0002 Rev=1 Len=16 <?>
> Capabilities: [110 v1] Designated Vendor-Specific: Vendor=8086
> ID=0003 Rev=1 Len=16 <?>
> Capabilities: [120 v1] Designated Vendor-Specific: Vendor=8086
> ID=0004 Rev=1 Len=16 <?>
> Kernel driver in use: intel_vsec
> Kernel modules: intel_vsec
> 
> 00:0d.0 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4
> USB Controller (rev 02) (prog-if 30 [XHCI])
> Subsystem: Lenovo Device 3801
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin ? routed to IRQ 126
> IOMMU group: 8
> Region 0: Memory at 601d1b0000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
> Address: 00000000fee002b8 Data: 0000
> Capabilities: [90] Vendor Specific Information: Len=14 <?>
> Capabilities: [b0] Vendor Specific Information: Len=00 <?>
> Kernel driver in use: xhci_hcd
> Kernel modules: xhci_pci
> 
> 00:0d.2 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4
> NHI #0 (rev 02) (prog-if 40 [USB4 Host Interface])
> Subsystem: Lenovo Device 3801
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> IOMMU group: 8
> Region 0: Memory at 601d140000 (64-bit, non-prefetchable) [size=256K]
> Region 2: Memory at 601d1da000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000 Data: 0000
> Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
> Vector table: BAR=2 offset=00000000
> PBA: BAR=2 offset=00000fa0
> Kernel driver in use: thunderbolt
> Kernel modules: thunderbolt
> 
> 00:0d.3 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4
> NHI #1 (rev 02) (prog-if 40 [USB4 Host Interface])
> Subsystem: Lenovo Device 3801
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> IOMMU group: 8
> Region 0: Memory at 601d100000 (64-bit, non-prefetchable) [size=256K]
> Region 2: Memory at 601d1d9000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000 Data: 0000
> Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
> Vector table: BAR=2 offset=00000000
> PBA: BAR=2 offset=00000fa0
> Kernel driver in use: thunderbolt
> Kernel modules: thunderbolt
> 
> 00:12.0 Serial controller: Intel Corporation Device 51fc (rev 01)
> (prog-if 00 [8250])
> Subsystem: Intel Corporation Device 7270
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 26
> IOMMU group: 9
> Region 0: Memory at 601d1a0000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
> ,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [90] Vendor Specific Information: Len=14 <?>
> Kernel driver in use: intel_ish_ipc
> Kernel modules: intel_ish_ipc
> 
> 00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI
> Host Controller (rev 01) (prog-if 30 [XHCI])
> Subsystem: Lenovo Device 381e
> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin A routed to IRQ 127
> IOMMU group: 10
> Region 0: Memory at 5e300000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
> Address: 00000000fee002d8 Data: 0000
> Capabilities: [90] Vendor Specific Information: Len=14 <?>
> Capabilities: [b0] Vendor Specific Information: Len=00 <?>
> Kernel driver in use: xhci_hcd
> Kernel modules: xhci_pci
> 
> 00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev
> 01)
> Subsystem: Lenovo Device 381f
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> IOMMU group: 10
> Region 0: Memory at 601d1d0000 (64-bit, non-prefetchable) [size=16K]
> Region 2: Memory at 601d1d8000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi
> WiFi (rev 01)
> Subsystem: Intel Corporation Device 0094
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> IOMMU group: 11
> Region 0: Memory at 601d1cc000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000 Data: 0000
> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI
> 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- FLReset+
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+
> 10BitTagReq- OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
> Vector table: BAR=0 offset=00002000
> PBA: BAR=0 offset=00003000
> Capabilities: [100 v1] Latency Tolerance Reporting
> Max snoop latency: 0ns
> Max no snoop latency: 0ns
> Capabilities: [164 v1] Vendor Specific Information: ID=0010 Rev=0
> Len=014 <?>
> Kernel driver in use: iwlwifi
> Kernel modules: iwlwifi
> 
> 00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #0 (rev 01)
> Subsystem: Lenovo Device 3818
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 27
> IOMMU group: 12
> Region 0: Memory at 4017000000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [90] Vendor Specific Information: Len=14 <?>
> Kernel driver in use: intel-lpss
> Kernel modules: intel_lpss_pci
> 
> 00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #1 (rev 01)
> Subsystem: Lenovo Device 3819
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin B routed to IRQ 40
> IOMMU group: 12
> Region 0: Memory at 4017001000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [90] Vendor Specific Information: Len=14 <?>
> Kernel driver in use: intel-lpss
> Kernel modules: intel_lpss_pci
> 
> 00:16.0 Communication controller: Intel Corporation Alder Lake PCH
> HECI Controller (rev 01)
> Subsystem: Lenovo Device 381d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 128
> IOMMU group: 13
> Region 0: Memory at 601d1d5000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
> ,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee002f8 Data: 0000
> Capabilities: [a4] Vendor Specific Information: Len=14 <?>
> Kernel driver in use: mei_me
> Kernel modules: mei_me
> 
> 00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller
> (rev 01)
> Subsystem: Lenovo Device 3801
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> IOMMU group: 14
> 
> 00:1f.3 Multimedia audio controller: Intel Corporation Alder Lake
> PCH-P High Definition Audio Controller (rev 01)
> Subsystem: Lenovo Device 381c
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 32, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 165
> IOMMU group: 14
> Region 0: Memory at 601d1c8000 (64-bit, non-prefetchable) [size=16K]
> Region 4: Memory at 601d000000 (64-bit, non-prefetchable) [size=1M]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-
> ,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [80] Vendor Specific Information: Len=14 <?>
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee007b8 Data: 0000
> Kernel driver in use: snd_hda_intel
> Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl
> 
> 00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host
> Controller (rev 01)
> Subsystem: Lenovo Device 3808
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin A routed to IRQ 16
> IOMMU group: 14
> Region 0: Memory at 601d1d4000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at efa0 [size=32]
> Kernel driver in use: i801_smbus
> Kernel modules: i2c_i801
> 
> 00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI
> Controller (rev 01)
> Subsystem: Lenovo Device 3809
> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> IOMMU group: 14
> Region 0: Memory at 50400000 (32-bit, non-prefetchable) [size=4K]
> Kernel driver in use: intel-spi
> Kernel modules: spi_intel_pci
> 
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
> NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
> Subsystem: Samsung Electronics Co Ltd Device a801
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> NUMA node: 0
> IOMMU group: 15
> Region 0: Memory at 5e200000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
> ,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
> Address: 0000000000000000 Data: 0000
> Capabilities: [70] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1
> unlimited
> ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
> MaxPayload 256 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1
> <64us
> ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 16GT/s, Width x4
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- TPHComp- ExtTPHComp-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+
> 10BitTagReq- OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
> LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+
> EqualizationPhase1+
> EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: Upstream Port
> Capabilities: [b0] MSI-X: Enable+ Count=130 Masked-
> Vector table: BAR=0 offset=00003000
> PBA: BAR=0 offset=00002000
> Capabilities: [100 v2] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+
> ECRCChkEn-
> MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
> ARICap: MFVC- ACS-, Next Function: 0
> ARICtl: MFVC- ACS-, Function Group: 0
> Capabilities: [178 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
> Capabilities: [1bc v1] Lane Margining at the Receiver <?>
> Capabilities: [214 v1] Latency Tolerance Reporting
> Max snoop latency: 15728640ns
> Max no snoop latency: 15728640ns
> Capabilities: [21c v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
> PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> T_CommonMode=0us LTR1.2_Threshold=589824ns
> L1SubCtl2: T_PwrOn=500us
> Capabilities: [3a0 v1] Data Link Feature <?>
> Kernel driver in use: nvme
> Kernel modules: nvme
> 
> [8.7.] Other information that might be relevant to the problem
> I suspect that the sensor hub does not answer sync read requests
> accurately.
> I didn't find any report of a similar issue so I'm asking here and
> hope that I
> provided enough needed information.
> 
> Thank you for your time,
> Philipp Jungkamp


